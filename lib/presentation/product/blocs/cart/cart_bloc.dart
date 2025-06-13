import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(InitialCartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cartItems = await cartRepository.getCartItems();
      emit(CartLoaded(items: cartItems));
    } catch (e) {
      emit(LoadCartError(errorMessage: e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      final success = await cartRepository.addToCart(event.productId);
      if (success) {
        final currentState = state;
        if (currentState is CartLoaded || currentState is CartAdded || currentState is CartRemoved) {
          final updatedItems = Map<String, int>.from(currentState.items);
          updatedItems[event.productId] = (updatedItems[event.productId] ?? 0) + 1;
          emit(CartAdded(items: updatedItems));
        } else {
          add(LoadCart());
        }
      }
    } catch (e) {
      emit(AddCartError(errorMessage: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      final success = await cartRepository.removeFromCart(event.productId);
      if (success) {
        final currentState = state;
        if (currentState is CartLoaded || currentState is CartAdded || currentState is CartRemoved) {
          final updatedItems = Map<String, int>.from(currentState.items);
          if (updatedItems.containsKey(event.productId)) {
            if (updatedItems[event.productId]! > 1) {
              updatedItems[event.productId] = updatedItems[event.productId]! - 1;
            } else {
              updatedItems.remove(event.productId);
            }
          }
          emit(CartRemoved(items: updatedItems));
        } else {
          add(LoadCart());
        }
      }
    } catch (e) {
      emit(RemoveCartError(errorMessage: e.toString()));
    }
  }
}
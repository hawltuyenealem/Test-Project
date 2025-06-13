import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/product_model.dart';
import '../../../../data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<LoadProduct>(_onLoadProduct);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadProduct(LoadProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final product = await productRepository.getProduct(event.productId);
      final isFavorite = await productRepository.isFavorite(event.productId);

      emit(ProductLoaded(
        product: product,
        isFavorite: isFavorite,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<ProductState> emit) async {
    try {
      final currentState = state;
      if (currentState is ProductLoaded) {
        await productRepository.setFavorite(event.productId, event.isFavorite);
        emit(FavoriteUpdated(
          product: currentState.product,
          isFavorite: event.isFavorite,
        ));
      }
    } catch (e) {
      final currentState = state;
      if (currentState is ProductLoaded) {
        emit(FavoriteError(
          errorMessage: e.toString(),
          product: currentState.product,
          isFavorite: currentState.isFavorite,
        ));
      } else {
        emit(FavoriteError(
          errorMessage: e.toString(),
          isFavorite: !event.isFavorite, // Revert to previous state
        ));
      }
    }
  }
}
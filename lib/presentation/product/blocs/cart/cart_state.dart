part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  Map<String, int> get items => {};
  int get totalItems => items.values.fold(0, (sum, quantity) => sum + quantity);

  @override
  List<Object?> get props => [];
}

class InitialCartState extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  @override
  final Map<String, int> items;

  CartLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class CartAdded extends CartLoaded {
  CartAdded({required super.items});
}

class CartRemoved extends CartLoaded {
  CartRemoved({required super.items});
}

class LoadCartError extends CartState {
  final String errorMessage;

  LoadCartError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AddCartError extends CartState {
  final String errorMessage;

  AddCartError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class RemoveCartError extends CartState {
  final String errorMessage;

  RemoveCartError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
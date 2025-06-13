part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  Product? get product => null;
  bool get isFavorite => false;

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  @override
  final Product product;
  @override
  final bool isFavorite;

  const ProductLoaded({
    required this.product,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [product, isFavorite];
}

class FavoriteUpdated extends ProductLoaded {
  const FavoriteUpdated({
    required super.product,
    required super.isFavorite,
  });
}

class ProductError extends ProductState {
  final String errorMessage;

  const ProductError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class FavoriteError extends ProductState {
  final String errorMessage;
  final Product? product;
  final bool isFavorite;

  const FavoriteError({
    required this.errorMessage,
    this.product,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [errorMessage, product, isFavorite];
}
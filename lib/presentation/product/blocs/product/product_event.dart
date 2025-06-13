part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProduct extends ProductEvent {
  final String productId;

  const LoadProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class ToggleFavorite extends ProductEvent {
  final String productId;
  final bool isFavorite;

  const ToggleFavorite({required this.productId,required this.isFavorite});

  @override
  List<Object> get props => [productId, isFavorite];
}
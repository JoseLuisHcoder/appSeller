import 'package:meta/meta.dart';

import '../../models/cart_product.dart';

@immutable
abstract class ProductState {
  final List<CartProduct>? products;
  final double total;
  final int amount;

  ProductState({this.products, this.total = 0.0, this.amount = 0});
}

class ProductInitial extends ProductState {}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {}

class FailureProductState extends ProductState {
  final String error;

  FailureProductState(this.error);
}

class SetAddProductToCartState extends ProductState {
  final List<CartProduct> products;
  final double total;

  final int amount;

  SetAddProductToCartState(
      {required this.products, required this.total, required this.amount})
      : super(products: products, total: total, amount: amount);
}

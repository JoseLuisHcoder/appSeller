import 'package:meta/meta.dart';

import '../../models/product.dart';

@immutable
abstract class ProductEvent {}

class OnAddOrDeleteProductFavoriteEvent extends ProductEvent {
  final int idProduct;

  OnAddOrDeleteProductFavoriteEvent({required this.idProduct});
}

class OnAddProductToCartEvent extends ProductEvent {
  final Product product;
  final int quantity;

  OnAddProductToCartEvent(this.product, this.quantity);
}

class OnDeleteProductToCartEvent extends ProductEvent {
  final int index;

  OnDeleteProductToCartEvent(this.index);
}

class OnSubstractProductToCartEvent extends ProductEvent {
  final int index;

  OnSubstractProductToCartEvent(this.index);
}

class OnAddQuantityProductToCartEvent extends ProductEvent {
  final int index;

  OnAddQuantityProductToCartEvent(this.index);
}

class OnLoadedCartEvent extends ProductEvent {
  OnLoadedCartEvent();
}

class OnNotLoadedCartEvent extends ProductEvent {
  OnNotLoadedCartEvent();
}

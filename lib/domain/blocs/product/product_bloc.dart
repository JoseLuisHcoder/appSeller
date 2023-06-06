import 'package:bloc/bloc.dart';
import 'package:vendedor/data/data.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/blocs/product/product_event.dart';
import 'package:vendedor/domain/blocs/product/product_state.dart';
import 'package:vendedor/domain/models/cart_product.dart';
import 'package:vendedor/domain/models/product.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:vendedor/domain/services/services.dart';
// import 'package:meta/meta.dart';

import '../../models/cart_product.dart';
import '../../models/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<OnAddOrDeleteProductFavoriteEvent>(_addOrDeleteProductFavorite);
    on<OnAddProductToCartEvent>(_addProductToCart);
    on<OnDeleteProductToCartEvent>(_deleteProductCart);
    on<OnSubstractProductToCartEvent>(_removeQuantityProductToCart);
    on<OnAddQuantityProductToCartEvent>(_addQuantityProductToCart);
    on<OnLoadedCartEvent>(_loadedCart);
    on<OnNotLoadedCartEvent>(_notLoadedCart);
  }

  Future<void> _addOrDeleteProductFavorite(
      OnAddOrDeleteProductFavoriteEvent event,
      Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());

      final data =
          await productServices.addOrDeleteProductFavorite(event.idProduct);

      if (data) {
        emit(SuccessProductState());
      } else {
        emit(FailureProductState("Error"));
      }
    } catch (e) {
      emit(FailureProductState(e.toString()));
    }
  }

  Future<void> _addProductToCart(
      OnAddProductToCartEvent event, Emitter<ProductState> emit) async {
    final hasProduct = productsCart.contains(event.product);

    final idCustomer = await secureStorage.readToken();

    final idCartAdd = await cartServices.addShopingCart(
        idCustomer: idCustomer!,
        idProduct: event.product.id,
        quantity: event.quantity);

    if (idCartAdd == -1) {
      emit(FailureProductState("No se puede agregar al carrito"));
      return;
    }
    await secureStorage.persistenCartId(idCartAdd.toString());

    if (!hasProduct) {
      productsCart.add(CartProduct(
          product: parseToCartProductSingle(event.product),
          quantity: event.quantity));

      double sum = 0;

      for (var e in productsCart) {
        sum = sum + (e.product.productPrice.price * e.quantity);
      }

      emit(SetAddProductToCartState(
          products: productsCart, total: sum, amount: productsCart.length));
    } else {
      for (int i = 0; i < productsCart.length; i++) {
        if (productsCart[i].product.id == event.product.id) {
          productsCart[i].quantity++;
          break;
        }
      }
    }
  }

  Future<void> _removeQuantityProductToCart(
      OnSubstractProductToCartEvent event, Emitter<ProductState> emit) async {
    final customerId = await secureStorage.readToken();
    if (customerId != null) {
      final remove = await cartServices.removeQuantityShopingCart(
          idCustomer: customerId, idProduct: event.index, quantity: -1);

      if (remove == false) {
        emit(FailureProductState("No se pudo quitar del carrito"));
        return;
      }
    }

    for (int i = 0; i < productsCart.length; i++) {
      if (productsCart[i].product.id == event.index) {
        if (productsCart[i].quantity == 1) {
          productsCart.removeAt(i);
        } else {
          productsCart[i].quantity--;
        }
      }
    }

    double sum = 0;
    for (var e in productsCart) {
      sum = sum + (e.product.productPrice.price * e.quantity);
    }

    emit(SetAddProductToCartState(
        products: productsCart, total: sum, amount: productsCart.length));
  }

  Future<void> _deleteProductCart(
      OnDeleteProductToCartEvent event, Emitter<ProductState> emit) async {
    final customerId = await secureStorage.readToken();
    if (customerId != null) {
      final remove = await cartServices.removeQuantityShopingCart(
          idCustomer: customerId, idProduct: event.index, quantity: -100);

      if (remove == false) {
        emit(FailureProductState("No se puede agregar al carrito"));
        return;
      }
    }

    for (int i = 0; i < productsCart.length; i++) {
      if (productsCart[i].product.id == event.index) {
        productsCart.removeAt(i);
      }
    }

    double sum = 0;
    for (var e in productsCart) {
      sum = sum + (e.product.productPrice.price * e.quantity);
    }

    emit(SetAddProductToCartState(
        products: productsCart, total: sum, amount: productsCart.length));
  }

  Future<void> _addQuantityProductToCart(
      OnAddQuantityProductToCartEvent event, Emitter<ProductState> emit) async {
    final customerId = await secureStorage.readToken();
    if (customerId != null) {
      final idCartAdd = await cartServices.addShopingCart(
          idCustomer: customerId, idProduct: event.index, quantity: 1);

      if (idCartAdd == -1) {
        emit(FailureProductState("No se puede agregar al carrito"));
        return;
      }
    } else {
      emit(FailureProductState("No se puede agregar al carrito"));
      return;
    }

    for (int i = 0; i < productsCart.length; i++) {
      if (productsCart[i].product.id == event.index) {
        productsCart[i].quantity++;
      }
    }

    double sum = 0;
    for (var e in productsCart) {
      sum = sum + (e.product.productPrice.price * e.quantity);
    }

    emit(SetAddProductToCartState(
        products: productsCart, total: sum, amount: productsCart.length));
  }

  Future<void> _loadedCart(
      OnLoadedCartEvent event, Emitter<ProductState> emit) async {
    double sum = 0;

    for (var e in productsCart) {
      sum = sum + (e.product.productPrice.price * e.quantity);
    }

    emit(SetAddProductToCartState(
        products: productsCart, total: sum, amount: productsCart.length));
  }

  Future<void> _notLoadedCart(
      OnNotLoadedCartEvent event, Emitter<ProductState> emit) async {
    secureStorage.persistenCartId("-1");

    productsCart = [];
    emit(SetAddProductToCartState(products: productsCart, total: 0, amount: 0));
    var product = productsCart;
    product;
  }
}

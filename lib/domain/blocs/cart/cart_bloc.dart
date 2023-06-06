import 'package:bloc/bloc.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/models/response/close_cart.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:meta/meta.dart';

import '../../models/response/close_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<OnFinishCartEvent>(_onFinishCart);
  }

  Future<void> _onFinishCart(
      OnFinishCartEvent event, Emitter<CartState> emit) async {
    final customerId = await secureStorage.readToken();
    if (customerId != null) {
      final order =
          await cartServices.closeCart(int.parse(customerId), null, null);

      if (order != null) {
        emit(SuccessCartState(order: order));
        return;
      } else {
        emit(FailureCartState());
      }
    } else {
      emit(FailureCartState());
    }
  }
}

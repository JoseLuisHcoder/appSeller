import 'package:bloc/bloc.dart';
import 'package:vendedor/data/data.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/blocs/blocs.dart';
import 'package:vendedor/domain/services/cart_services.dart';
import 'package:vendedor/domain/services/services.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<CheckLoginEvent>(_checkingLogin);
    on<LogOutEvent>(_logout);
  }

  Future<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());

      final data = await authServices.login(
          email: event.email, password: event.password);

      if (data.status.code == 200) {
        await secureStorage.deleteToken();

        await secureStorage.persistenToken(data.body["customer_id"].toString());
        var getCard =
            await cartServices.getCartByCustomer(data.body["customer_id"]);
        if (getCard != null) {
          productsCart = getCard;
          emit(SuccessCartLoaded());
        } else {
          productsCart = [];
          emit(FailureCartLoaded());
        }

        emit(SuccessAuthState());
      } else {
        emit(FailureAuthState(error: data.status.message));
      }
    } catch (e) {
      emit(FailureAuthState(error: e.toString()));
    }
  }

  Future<void> _checkingLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      emit(LoadingAuthState());
      final idCustomer = await secureStorage.readToken();
      if (await secureStorage.readToken() != null) {
        var getCard =
            await cartServices.getCartByCustomer(int.parse(idCustomer!));
        if (getCard != null) {
          productsCart = getCard;
          emit(SuccessCartLoaded());
        } else {
          productsCart = [];
          emit(FailureCartLoaded());
        }
        emit(SuccessCartLoaded());
        emit(SuccessAuthState());
      } else {
        await secureStorage.deleteToken();
        emit(LogOutState());
      }
    } catch (e) {
      await secureStorage.deleteToken();
      emit(LogOutState());
    }
  }

  Future<void> _logout(LogOutEvent event, Emitter<AuthState> emit) async {
    secureStorage.deleteToken();
    emit(LogOutState());
  }
}

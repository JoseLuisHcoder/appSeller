import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:vendedor/data/secure_storage.dart';
import 'package:vendedor/domain/services/auth_services.dart';

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

      if (data != null) {
        await secureStorage.deleteToken();

        await secureStorage.persistenToken(data.toString());
        emit(SuccessAuthState());
      } else {
        emit(FailureAuthState(error: "no se pudo iniciar sesión"));
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
      if (await secureStorage.readToken() != null) {
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

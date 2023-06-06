part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class LoadingCartState extends CartState {}

class SuccessCartState extends CartState {
  final ResponseOrder order;
  SuccessCartState({required this.order});
}

class FailureCartState extends CartState {}

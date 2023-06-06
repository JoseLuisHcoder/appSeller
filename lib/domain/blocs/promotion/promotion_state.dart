part of 'promotion_bloc.dart';

@immutable
abstract class PromotionState {}

class PromotionInitial extends PromotionState {}

class LoadingPromotionState extends PromotionState {}

class LoadedPromotionState extends PromotionState {
  final List<ProductPromotions> promotion;
  LoadedPromotionState({required this.promotion});
}

class FailurePromotionState extends PromotionState {}

class LoadingBestSellingState extends PromotionState {}

class LoadedBestSellingState extends PromotionState {
  final List<Product> bestselling;
  LoadedBestSellingState({required this.bestselling});
}

class FailureBestSellingState extends PromotionState {}

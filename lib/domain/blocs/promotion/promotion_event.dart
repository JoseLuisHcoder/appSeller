part of 'promotion_bloc.dart';

@immutable
abstract class PromotionEvent {}

class OnLoadedPromotionEvent extends PromotionEvent {
  OnLoadedPromotionEvent();
}

class OnLoadedBestSellingEvent extends PromotionEvent {
  OnLoadedBestSellingEvent();
}

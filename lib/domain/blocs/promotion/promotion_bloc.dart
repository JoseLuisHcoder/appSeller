import 'package:bloc/bloc.dart';
import 'package:vendedor/domain/models/product.dart';
import 'package:vendedor/domain/models/response/product_promotions.dart';
import 'package:vendedor/domain/services/product_promotions_service.dart';
import 'package:vendedor/domain/services/product_services.dart';
import 'package:meta/meta.dart';
import 'package:vendedor/domain/models/response/product_promotions.dart';

import '../../models/product.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  PromotionBloc() : super(PromotionInitial()) {
    on<OnLoadedPromotionEvent>(_loadedPromotion);
    on<OnLoadedBestSellingEvent>(_loadedBestSelling);
  }

  Future<void> _loadedPromotion(
      OnLoadedPromotionEvent event, Emitter<PromotionState> emit) async {
    emit(LoadingPromotionState());

    List<ProductPromotions>? promotion =
        await productPromotion.getProductsPromotions();

    if (promotion == null) {
      emit(FailurePromotionState());
      return;
    }

    emit(LoadedPromotionState(promotion: promotion));
  }

  Future<void> _loadedBestSelling(
      OnLoadedBestSellingEvent event, Emitter<PromotionState> emit) async {
    emit(LoadingBestSellingState());

    List<Product>? bestselling =
        await productServices.listProductsBestSellings();

    if (bestselling == null) {
      emit(FailureBestSellingState());
      return;
    }

    emit(LoadedBestSellingState(bestselling: bestselling));
  }
}

import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/delete_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_iphone_detail_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/update_iphone_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_alert_dialog_reanswer.dart';

class ProductDetailState {
  final IphoneProductEntity iphoneProduct;

  ProductDetailState({required this.iphoneProduct});

  ProductDetailState copyWith({
    IphoneProductEntity? iphoneProductEntity,
  }) {
    return ProductDetailState(
      iphoneProduct: iphoneProductEntity ?? iphoneProduct,
    );
  }
}

class ProductDetailViewModel extends ChangeNotifier {
  final ProductType productType;
  final String productId;
  final BuildContext context;
  final GetIphoneDetailUseCase getIphoneDetailUsecase;
  final DeleteIphoneUseCase deleteIphoneUseCase;
  final UpdateIphoneUseCase updateIphoneUseCase;

  ProductDetailState state =
      ProductDetailState(iphoneProduct: IphoneProductEntity.empty());

  ProductDetailViewModel({
    required this.productType,
    required this.productId,
    required this.context,
    required this.getIphoneDetailUsecase,
    required this.deleteIphoneUseCase,
    required this.updateIphoneUseCase,
  }) {
    getIphoneDetail();
  }

  Future<void> getIphoneDetail() async {
    final result = await getIphoneDetailUsecase(productId, productType);
    result.fold(
      (left) => null,
      (right) {
        state = state.copyWith(iphoneProductEntity: right);
      },
    );
    notifyListeners();
  }

  Future<void> onDeleteButtonPress() async {
    final isDelete = await showAlertDialogDelete(context: context);
    if (isDelete != null && isDelete) {
      await deleteIphoneUseCase(productId, productType);

      returnToPreviosPage();
    }
    notifyListeners();
  }

  void onEditButtonPress() async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.formForIphone,
      arguments: state.iphoneProduct,
    );
    await getIphoneDetail();
  }

  void onSellButtonPress() async {
    final isSell = await showAlertDialogDelete(context: context);
    if (isSell != null && isSell) {
      if (state.iphoneProduct.status == ProductStatus.sold) {
        await updateIphoneUseCase(
          state.iphoneProduct.copyWith(
            status: ProductStatus.instock,
          ),
        );
      } else {
        await updateIphoneUseCase(
          state.iphoneProduct.copyWith(
            status: ProductStatus.sold,
          ),
        );
      }

      getIphoneDetail();
    }
  }

  void returnToPreviosPage() {
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

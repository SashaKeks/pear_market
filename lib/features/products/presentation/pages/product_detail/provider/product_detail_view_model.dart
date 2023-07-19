import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/delete_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_product_detail_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_alert_dialog_reanswer.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class ProductDetailState {
  final ProductEntity product;

  ProductDetailState({required this.product});

  ProductDetailState copyWith({
    ProductEntity? productEntity,
  }) {
    return ProductDetailState(
      product: productEntity ?? product,
    );
  }
}

class ProductDetailViewModel extends ChangeNotifier {
  final ProductType productType;
  final String productId;
  final BuildContext context;
  final GetProductDetailUseCase getProductDetailUsecase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  ProductDetailState state = ProductDetailState(product: ProductEntity.empty());

  ProductDetailViewModel({
    required this.productType,
    required this.productId,
    required this.context,
    required this.getProductDetailUsecase,
    required this.deleteProductUseCase,
    required this.updateProductUseCase,
  }) {
    getProductDetail();
  }

  Future<void> getProductDetail() async {
    final result = await getProductDetailUsecase(productId);
    result.fold(
      (left) => showSnackbarInfo(context, "Failed load product"),
      (right) {
        state = state.copyWith(productEntity: right);
      },
    );
    notifyListeners();
  }

  Future<void> onDeleteButtonPress() async {
    final isDelete = await showAlertDialogDelete(context: context);
    if (isDelete != null && isDelete) {
      await deleteProductUseCase(productId);

      returnToPreviosPage();
    }
    notifyListeners();
  }

  void onEditButtonPress() async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.formForProduct,
      arguments: state.product,
    );
    await getProductDetail();
  }

  void onSellButtonPress() async {
    await Navigator.pushNamed(
      context,
      AppNavigationNames.sellProduct,
      arguments: state.product,
    );

    getProductDetail();
  }

  void returnToPreviosPage() {
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}

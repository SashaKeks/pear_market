import 'package:flutter/material.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class SellProductViewModel extends ChangeNotifier {
  ProductEntity product;
  final BuildContext context;
  final UpdateProductUseCase updateProductUseCase;
  final formKey = GlobalKey<FormState>();
  bool showExRateField = false;
  SellProductViewModel({
    required this.product,
    required this.context,
    required this.updateProductUseCase,
  }) {
    init();
    showExRateInit();
  }

  void init() {
    product = product.copyWith(
        sellCurrency: ProductCurrency.UAH, sellDateTime: DateTime.now());
  }

  void showExRateInit() {
    showExRateField = product.sellCurrency != ProductCurrency.UAH;
    notifyListeners();
  }

  void addProductSellPrice(String? price) {
    if (price == null) return;

    product = product.copyWith(
      sellPrice: double.tryParse(price),
    );
    notifyListeners();
  }

  void addProductSellCurrency(int? currency) {
    if (currency == null) return;

    product = product.copyWith(
      sellCurrency: ProductCurrency.values[currency],
    );
    showExRateInit();
  }

  void addProductSellExRate(String? exrate) {
    if (exrate == null) return;

    product = product.copyWith(
      sellExRate: double.tryParse(exrate),
    );
    notifyListeners();
  }

  void addSellDateTime(DateTime time) {
    product = product.copyWith(
      sellDateTime: time,
    );
    notifyListeners();
    Navigator.of(context).pop();
  }

  void onSellPress() {
    if (formKey.currentState!.validate()) {
      product = product.copyWith(status: ProductStatus.sold);
      updateProductUseCase(product);
      Navigator.of(context).pop();
    } else {
      showSnackbarInfo(context, "Fields are wrong cheak it and try again");
    }
  }
}

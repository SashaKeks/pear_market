import 'package:flutter/widgets.dart';
import 'package:pear_market/core/util/enums/product_condition_enum.dart';
import 'package:pear_market/core/util/enums/product_currency_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/add_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';

class AddProductOtherViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  ProductEntity product = ProductEntity.empty();
  final BuildContext context;
  final ProductEntity? editProduct;
  final ProductTypeEnum? productType;
  final UpdateProductUseCase updateProductUseCase;
  final AddProductUseCase addProductUseCase;

  AddProductOtherViewModel({
    required this.context,
    required this.editProduct,
    required this.productType,
    required this.addProductUseCase,
    required this.updateProductUseCase,
  }) {
    init();
  }
  void init() {
    if (editProduct != null) {
      product = editProduct!;
    }
    product = product.copyWith(type: productType ?? editProduct?.type);
    notifyListeners();
  }

  void onSavePress() async {
    if (formKey.currentState!.validate()) {
      if (editProduct == null) {
        await addProductUseCase(product);
      } else {
        await updateProductUseCase(product);
      }
      goBAck();
    } else {
      showSnackbarError(context, "Fields are wrong cheak it and try again");
    }
  }

  void goBAck() {
    Navigator.pop(context);
  }

  void onConditionChange(ProductConditionEnum? condition) {
    if (condition == null) return;
    product = product.copyWith(condition: condition);
    notifyListeners();
  }

  void onGenerationChange(String? generation) {
    if (generation == null) return;
    product = product.copyWith(generation: generation);
    notifyListeners();
  }

  void onColorChange(String? color) {
    if (color == null) return;
    product = product.copyWith(color: color);
    notifyListeners();
  }

  void onStorageChange(String? storage) {
    if (storage == null) return;
    product = product.copyWith(storage: storage);
    notifyListeners();
  }

  void onProcChange(String? proc) {
    if (proc == null) return;
    product = product.copyWith(proc: proc);
    notifyListeners();
  }

  void onRamChange(String? ram) {
    if (ram == null) return;
    product = product.copyWith(ram: ram);
    notifyListeners();
  }

  void onVideoChange(String? video) {
    if (video == null) return;
    product = product.copyWith(video: video);
    notifyListeners();
  }

  void onBuyPriceChange(String? price) {
    if (price == null) return;

    product = product.copyWith(buyPrice: double.tryParse(price) ?? 0);
    notifyListeners();
  }

  void onBuyCurrencyChange(ProductCurrencyEnum? currency) {
    if (currency == null) return;
    product = product.copyWith(buyCurrency: currency);
    notifyListeners();
  }

  void onBuyExRateChange(String? exrate) {
    if (exrate == null) return;
    product = product.copyWith(buyExRate: double.tryParse(exrate) ?? 1);
    notifyListeners();
  }

  void onBuyDateTimeChange(DateTime? buyDateTime) {
    if (buyDateTime == null) return;
    product = product.copyWith(buyDateTime: buyDateTime);
    notifyListeners();
    goBAck();
  }

  void onDescriptionChange(String? description) {
    if (description == null) return;
    product = product.copyWith(description: description);
    notifyListeners();
  }
}

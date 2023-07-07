import 'package:flutter/material.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/add_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class FormForProductState {
  final ProductEntity product;
  final List<String> generationList;
  final List<String> colorList;
  final List<String> storageList;
  final bool showExRateField;

  FormForProductState({
    required this.product,
    this.generationList = const [],
    this.colorList = const [],
    this.storageList = const [],
    this.showExRateField = false,
  });

  FormForProductState copyWith({
    ProductEntity? product,
    List<String>? generationList,
    List<String>? colorList,
    List<String>? storageList,
    bool? showExRateField,
  }) {
    return FormForProductState(
      product: product ?? this.product,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storageList: storageList ?? this.storageList,
      showExRateField: showExRateField ?? this.showExRateField,
    );
  }
}

class FormForProductViewModel extends ChangeNotifier {
  final BuildContext context;
  final ProductType? productType;
  final formKey = GlobalKey<FormState>();
  final ProductEntity? editproduct;
  late FormForProductState state = FormForProductState(
    product: editproduct ?? ProductEntity.empty(),
    showExRateField: editproduct == null
        ? false
        : editproduct?.buyCurrency != ProductCurrency.UAH,
  );

  /// product add usecase
  final AddProductUseCase addProductUseCase;

  /// product update usecase
  final UpdateProductUseCase updateProductUseCase;

  /// product generation usecase
  final GetProductGenerationParameterUsecase getProductGenerationUsecase;

  /// product color usecase
  final GetProductColorParameterUsecase getProductColorUsecase;

  /// product storage usecase
  final GetProductStorageParameterUsecase getProductStorageUsecase;

  /// product version usecase
  final GetProductVersionParameterUsecase getProductVersionUsecase;

  FormForProductViewModel({
    required this.context,
    required this.productType,
    required this.editproduct,
    required this.addProductUseCase,
    required this.getProductGenerationUsecase,
    required this.getProductStorageUsecase,
    required this.updateProductUseCase,
    required this.getProductColorUsecase,
    required this.getProductVersionUsecase,
  }) {
    initFields();
    print(productType);
  }
  Future<void> initFields() async {
    state = state.copyWith(
        product:
            state.product.copyWith(type: productType ?? editproduct?.type));
    await getProductGeneration();
    await getProductStorage();
  }

  Future<void> getProductGeneration() async {
    final result = await getProductGenerationUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarInfo(context, l.errorMessage),
      (right) {
        state = state.copyWith(
          generationList: right,
        );
        if (editproduct == null) {
          state = state.copyWith(
            product: state.product.copyWith(
              generation: right.last,
            ),
          );
        }
      },
    );
    await getProductColors(state.product.generation);
    notifyListeners();
  }

  Future<void> getProductColors(String generetion) async {
    final result = await getProductColorUsecase(
      state.product.type.name,
      generetion,
    );
    result.fold(
      (l) => showSnackbarInfo(context, l.errorMessage),
      (right) {
        state = state.copyWith(
          colorList: right,
        );
        if (state.product.color.isEmpty) {
          state = state.copyWith(
            product: state.product.copyWith(
              color: right.last,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  Future<void> getProductStorage() async {
    final result = await getProductStorageUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarInfo(context, l.errorMessage),
      (right) {
        state = state.copyWith(
          storageList: right,
        );
        if (editproduct == null) {
          state = state.copyWith(
            product: state.product.copyWith(
              storage: right.last,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  void addProductColor(String? color) {
    if (color == null) return;

    state = state.copyWith(product: state.product.copyWith(color: color));
    notifyListeners();
  }

  void addProductBuyPrice(String? price) {
    if (price == null) return;

    state = state.copyWith(
        product: state.product.copyWith(buyPrice: double.tryParse(price) ?? 0));
    notifyListeners();
  }

  void addProductBuyCurrency(int? currency) {
    if (currency == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        buyCurrency: ProductCurrency.values[currency],
        buyExRate: 1,
      ),
      showExRateField: ProductCurrency.values[currency] != ProductCurrency.UAH,
    );
    notifyListeners();
  }

  void addProductBuyExRate(String? exRate) {
    if (exRate == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        buyExRate: double.tryParse(exRate) ?? 1,
      ),
    );
    notifyListeners();
  }

  void addProductStorage(String? storage) {
    if (storage == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        storage: storage,
      ),
    );
    notifyListeners();
  }

  void addProductCondition(int? condition) {
    if (condition == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        condition: ProductCondition.values[condition],
      ),
    );
    notifyListeners();
  }

  void addProductGeneration(String? generation) {
    if (generation == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        generation: generation,
        color: "",
      ),
      colorList: [],
    );
    getProductColors(state.product.generation);
    notifyListeners();
  }

  void addProductDescription(String? description) {
    if (description == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        description: description,
      ),
    );
    getProductColors(state.product.generation);
    notifyListeners();
  }

  void addBuyDateTime(DateTime time) {
    state = state.copyWith(
      product: state.product.copyWith(
        buyDateTime: time,
      ),
    );

    notifyListeners();
    returnToPreviosPage();
  }

  void saveProduct() async {
    if (formKey.currentState!.validate()) {
      if (editproduct == null) {
        await addProductUseCase(state.product);
      } else {
        await updateProductUseCase(state.product);
      }
      returnToPreviosPage();
    } else {
      showSnackbarInfo(context, "Fields are wrong cheak it and try again");
    }
  }

  void returnToPreviosPage() {
    if (!context.mounted) return;
    Navigator.pop(context);
  }
}

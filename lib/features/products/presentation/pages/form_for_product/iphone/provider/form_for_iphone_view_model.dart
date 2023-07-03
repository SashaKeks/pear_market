import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/add_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/update_iphone_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class FormForIphoneState {
  final IphoneProductEntity product;
  final List<String> generationList;
  final List<String> colorList;
  final List<String> storageList;
  final bool showExRateField;

  FormForIphoneState({
    required this.product,
    this.generationList = const [],
    this.colorList = const [],
    this.storageList = const [],
    this.showExRateField = false,
  });

  FormForIphoneState copyWith({
    IphoneProductEntity? product,
    List<String>? generationList,
    List<String>? colorList,
    List<String>? storageList,
    bool? showExRateField,
  }) {
    return FormForIphoneState(
      product: product ?? this.product,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storageList: storageList ?? this.storageList,
      showExRateField: showExRateField ?? this.showExRateField,
    );
  }
}

class FormForIphoneViewModel extends ChangeNotifier {
  final BuildContext context;
  final formKey = GlobalKey<FormState>();
  final IphoneProductEntity? editproduct;
  late FormForIphoneState state = FormForIphoneState(
    product: editproduct ?? IphoneProductEntity.empty(),
    showExRateField: editproduct == null
        ? false
        : editproduct?.buyCurrency != ProductCurrency.UAH,
  );

  /// iphone add usecase
  final AddIphoneUseCase addIphoneUseCase;

  /// iphone update usecase
  final UpdateIphoneUseCase updateIphoneUseCase;

  /// iphone generation usecase
  final GetProductGenerationParameterUsecase getProductGenerationUsecase;

  /// iphone color usecase
  final GetProductColorParameterUsecase getProductColorUsecase;

  /// iphone storage usecase
  final GetProductStorageParameterUsecase getProductStorageUsecase;

  /// iphone version usecase
  final GetProductVersionParameterUsecase getProductVersionUsecase;

  FormForIphoneViewModel({
    required this.context,
    required this.editproduct,
    required this.addIphoneUseCase,
    required this.getProductGenerationUsecase,
    required this.getProductStorageUsecase,
    required this.updateIphoneUseCase,
    required this.getProductColorUsecase,
    required this.getProductVersionUsecase,
  }) {
    initFields();
  }
  Future<void> initFields() async {
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
        await addIphoneUseCase(state.product);
      } else {
        await updateIphoneUseCase(state.product);
      }
    } else {
      showSnackbarInfo(context, "Fields are wrong cheak it and try again");
    }
    returnToPreviosPage();
  }

  void returnToPreviosPage() {
    if (!context.mounted) return;
    Navigator.pop(context);
  }
}

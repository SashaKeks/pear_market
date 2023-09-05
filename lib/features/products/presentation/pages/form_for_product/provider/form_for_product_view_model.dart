import 'package:flutter/material.dart';
import 'package:pear_market/core/service/user_access_service.dart';
import 'package:pear_market/core/util/enums/product_condition_enum.dart';

import 'package:pear_market/core/util/enums/product_currency_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_proc_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_ram_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_video_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/add_product_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';

class FormForProductState {
  final ProductEntity product;
  final List<String> generationList;
  final List<String> colorList;
  final List<String> storageList;
  final List<String> videoList;
  final List<String> ramList;
  final List<String> procList;
  final bool showExRateField;

  FormForProductState({
    required this.product,
    this.generationList = const [],
    this.colorList = const [],
    this.storageList = const [],
    this.ramList = const [],
    this.procList = const [],
    this.videoList = const [],
    this.showExRateField = false,
  });

  FormForProductState copyWith({
    ProductEntity? product,
    List<String>? generationList,
    List<String>? colorList,
    List<String>? storageList,
    List<String>? videoList,
    List<String>? ramList,
    List<String>? procList,
    bool? showExRateField,
  }) {
    return FormForProductState(
      product: product ?? this.product,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storageList: storageList ?? this.storageList,
      videoList: videoList ?? this.videoList,
      ramList: ramList ?? this.ramList,
      procList: procList ?? this.procList,
      showExRateField: showExRateField ?? this.showExRateField,
    );
  }
}

class FormForProductViewModel extends ChangeNotifier {
  final BuildContext context;
  final ProductTypeEnum? productType;
  final UserAccessService userAccessService;
  final formKey = GlobalKey<FormState>();
  final ProductEntity? editproduct;
  late FormForProductState state = FormForProductState(
    product: editproduct ?? ProductEntity.empty(),
    showExRateField: editproduct == null
        ? false
        : editproduct?.buyCurrency != ProductCurrencyEnum.UAH,
  );

  /// product add usecase
  final AddProductUseCase addProductUseCase;

  /// product update usecase
  final UpdateProductUseCase updateProductUseCase;

  /// product generation usecase
  final GetProductGenerationParameterUsecase getProductGenerationUsecase;

  /// product color usecase
  final GetProductColorParameterUsecase getProductColorUsecase;

  /// product color usecase
  final GetProductProcParameterUsecase getProductProcUsecase;

  /// product color usecase
  final GetProductVideoParameterUsecase getProductVideoUsecase;

  /// product color usecase
  final GetProductRamParameterUsecase getProductRamUsecase;

  /// product storage usecase
  final GetProductStorageParameterUsecase getProductStorageUsecase;

  /// product version usecase
  final GetProductVersionParameterUsecase getProductVersionUsecase;

  FormForProductViewModel({
    required this.getProductProcUsecase,
    required this.getProductVideoUsecase,
    required this.getProductRamUsecase,
    required this.context,
    required this.productType,
    required this.editproduct,
    required this.addProductUseCase,
    required this.getProductGenerationUsecase,
    required this.getProductStorageUsecase,
    required this.updateProductUseCase,
    required this.getProductColorUsecase,
    required this.getProductVersionUsecase,
    required this.userAccessService,
  }) {
    initFields();
  }
  Future<void> initFields() async {
    state = state.copyWith(
        product:
            state.product.copyWith(type: productType ?? editproduct?.type));
    await getProductGeneration();
    if (state.product.type == ProductTypeEnum.mac ||
        state.product.type == ProductTypeEnum.iphone ||
        state.product.type == ProductTypeEnum.ipad) {
      await getProductStorage();
    }

    if (state.product.type == ProductTypeEnum.mac) {
      await getProductProc();
      await getProductRam();
      await getProductVideo();
    }
  }

  Future<void> getProductGeneration() async {
    final result = await getProductGenerationUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarError(context, "Failed load product generation"),
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

  Future<void> getProductRam() async {
    final result = await getProductRamUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarError(context, "Failed load product RAM"),
      (right) {
        state = state.copyWith(
          ramList: right,
        );
        if (editproduct == null) {
          state = state.copyWith(
            product: state.product.copyWith(
              ram: right.last,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  Future<void> getProductProc() async {
    final result = await getProductProcUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarError(context, "Failed load product processors"),
      (right) {
        state = state.copyWith(
          procList: right,
        );
        if (editproduct == null) {
          state = state.copyWith(
            product: state.product.copyWith(
              proc: right.last,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  Future<void> getProductVideo() async {
    final result = await getProductVideoUsecase(
      state.product.type.name,
    );
    result.fold(
      (l) => showSnackbarError(context, "Failed load product video cards"),
      (right) {
        state = state.copyWith(
          videoList: right,
        );
        if (editproduct == null) {
          state = state.copyWith(
            product: state.product.copyWith(
              video: right.last,
            ),
          );
        }
      },
    );
    notifyListeners();
  }

  Future<void> getProductColors(String generetion) async {
    final result = await getProductColorUsecase(
      state.product.type.name,
      generetion,
    );
    result.fold(
      (l) => showSnackbarError(context, "Failed load product colors"),
      (right) {
        state = state.copyWith(
          colorList: right,
        );
        if (state.product.color?.isEmpty ?? true) {
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
      (l) => showSnackbarError(context, "Failed load product storages"),
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
        buyCurrency: ProductCurrencyEnum.values[currency],
        buyExRate: 1,
      ),
      showExRateField:
          ProductCurrencyEnum.values[currency] != ProductCurrencyEnum.UAH,
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
        condition: ProductConditionEnum.values[condition],
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
    notifyListeners();
    getProductColors(state.product.generation);
  }

  void addProductRam(String? ram) {
    if (ram == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        ram: ram,
      ),
    );
    notifyListeners();
  }

  void addProductProc(String? proc) {
    if (proc == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        proc: proc,
      ),
    );
    notifyListeners();
  }

  void addProductVideo(String? video) {
    if (video == null) return;

    state = state.copyWith(
      product: state.product.copyWith(
        video: video,
      ),
    );
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
        await addProductUseCase(state.product
            .copyWith(ownerid: (await userAccessService.currentUser())?.id));
      } else {
        await updateProductUseCase(state.product);
      }
      returnToPreviosPage();
    } else {
      showSnackbarError(context, "Fields are wrong cheak it and try again");
    }
  }

  void returnToPreviosPage() {
    if (!context.mounted) return;
    Navigator.pop(context);
  }
}

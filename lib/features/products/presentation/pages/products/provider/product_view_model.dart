import 'package:flutter/material.dart';
import 'package:pear_market/core/service/user_access_service.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/get_user_by_id_usecase.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';
import 'package:pear_market/features/products/domain/entities/filter_entity.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_color_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_generation_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_storage_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/produc_parameters/get_product_version_parameter_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_all_products_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

import '../../../../../../core/service/service_navigation.dart';

class ProductState {
  final List<ProductEntity> productList;
  final List<String> generationList;
  final List<String?> colorList;
  final List<String> storagetList;
  final List<String> versiontList;
  final FilterEntity filter;

  ProductState({
    this.generationList = const [],
    this.colorList = const [],
    this.storagetList = const [],
    this.productList = const [],
    this.versiontList = const [],
    required this.filter,
  });

  ProductState copyWith({
    List<ProductEntity>? productList,
    List<String>? generationList,
    List<String>? colorList,
    List<String>? storagetList,
    List<String>? versiontList,
    FilterEntity? filter,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storagetList: storagetList ?? this.storagetList,
      versiontList: versiontList ?? this.versiontList,
      filter: filter ?? this.filter,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  final BuildContext context;
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  ProductState _state = ProductState(filter: FilterEntity());
  ProductState get state => _state;

  ///usecase
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetProductGenerationParameterUsecase generationParameterUsecase;
  final GetProductStorageParameterUsecase storageParameterUsecase;
  final GetProductColorParameterUsecase colorParameterUsecase;
  final GetProductVersionParameterUsecase versionParameterUsecase;
  final Generation generation;
  final UserAccessService userAccessService;
  final GetUserByIdUsecase getUserByIdUsecase;
  ProductViewModel(
    this.userAccessService, {
    required this.getAllProductsUseCase,
    required this.generationParameterUsecase,
    required this.storageParameterUsecase,
    required this.colorParameterUsecase,
    required this.versionParameterUsecase,
    required this.context,
    required this.generation,
    required this.getUserByIdUsecase,
  }) {
    init();
    getProductColor(generation.generation);
  }
  void init() {
    _state = _state.copyWith(
        filter:
            _state.filter.copyWith(generation: () => generation.generation));
    getAllProducts();

    if (generation.type != ProductType.accessories &&
        generation.type != ProductType.other) {
      getProductGeneration();
    }

    if (generation.type == ProductType.mac ||
        generation.type == ProductType.iphone ||
        generation.type == ProductType.ipad) {
      getProductStorage();
    }
  }

  Future<CustomUser> getProductOwner(String userId) async {
    final result = await getUserByIdUsecase(userId);
    return result.fold(
        (l) => showSnackbarInfo(context, "Failed get owner"), (r) => r);
  }

  void getProductGeneration() async {
    final generations = await generationParameterUsecase(generation.type!.name);
    generations.fold(
      (l) => showSnackbarInfo(context, "Failed load generation"),
      (r) => _state = _state.copyWith(generationList: r),
    );
  }

  Future<void> getProductColor(String? productGeneration) async {
    if (productGeneration == null) {
      _state = _state.copyWith(colorList: []);
    } else {
      final colors =
          await colorParameterUsecase(generation.type!.name, productGeneration);
      colors.fold(
        (l) => showSnackbarInfo(context, "Failed load colors"),
        (r) => _state = _state.copyWith(colorList: r),
      );
    }

    notifyListeners();
  }

  Future<void> getProductStorage() async {
    final storages = await storageParameterUsecase(generation.type!.name);
    storages.fold(
      (l) => showSnackbarInfo(context, "Failed load storages"),
      (r) => _state = _state.copyWith(storagetList: r),
    );
    notifyListeners();
  }

  Future<void> getProductVersion() async {
    final versions = await versionParameterUsecase(generation.type!.name);
    versions.fold(
      (l) => showSnackbarInfo(context, "Failed load versions"),
      (r) => _state = _state.copyWith(versiontList: r),
    );
    notifyListeners();
  }

  Future<void> onFilterButtonPress(FilterEntity? filter) async {
    _state = _state.copyWith(filter: filter ?? FilterEntity());
    await getAllProducts();
  }

  Future<void> getAllProducts() async {
    final result =
        await getAllProductsUseCase(generation.type!, _state.filter.toJson());
    result.fold(
      (l) => showSnackbarInfo(context, "Failed load products"),
      (right) => _state = _state.copyWith(
        productList: right,
      ),
    );
    notifyListeners();
  }

  void onSellButtonPress(int index) async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.sellProduct,
      arguments: _state.productList[index],
    );
    getAllProducts();
  }

  void onAddProductButtonPress() async {
    await Navigator.pushNamed(context, AppNavigationNames.formForProduct,
        arguments: generation.type!);
    getAllProducts();
  }

  void onDetailProductButton(int index) async {
    await Navigator.of(context).pushNamed(AppNavigationNames.productDetail,
        arguments: {
          "id": _state.productList[index].id,
          "type": _state.productList[index].type
        });
    getAllProducts();
  }

  void onNavigationPop() {
    Navigator.pop(context);
  }
}

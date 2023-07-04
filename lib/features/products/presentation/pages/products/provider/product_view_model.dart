import 'package:flutter/material.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/get_all_products_usecase.dart';
import 'package:pear_market/features/products/domain/usecase/product_usecases/update_product_usecase.dart';

import '../../../../../../core/service/service_navigation.dart';

class ProductState {
  final List<ProductEntity> productList;
  ProductState({
    required this.productList,
  });

  ProductState copyWith({
    List<ProductEntity>? productList,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  final BuildContext context;
  final ProductType productType;
  ProductState _state = ProductState(productList: []);
  ProductState get state => _state;

  ///usecase
  final GetAllProductsUseCase getAllProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  ProductViewModel({
    required this.getAllProductsUseCase,
    required this.updateProductUseCase,
    required this.context,
    required this.productType,
  }) {
    getAllProducts();
  }

  Future<void> getAllProducts() async {
    final result = await getAllProductsUseCase(productType);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed load products...'),
            backgroundColor: (Colors.black12),
          ),
        );
      },
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
    await Navigator.pushNamed(context, AppNavigationNames.formForProduct);
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
}

import 'package:flutter/material.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_all_iphones_usecase.dart';

import '../../../../../../core/service/service_navigation.dart';

class _ProductState {
  final List<IphoneProductEntity> productList;
  _ProductState({
    required this.productList,
  });

  _ProductState copyWith({
    List<IphoneProductEntity>? productList,
  }) {
    return _ProductState(
      productList: productList ?? this.productList,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  final GetAllIphonesUseCase getAllIphonesUseCase;
  final BuildContext context;
  final ProductType productType;
  _ProductState state = _ProductState(productList: []);
  ProductViewModel({
    required this.getAllIphonesUseCase,
    required this.context,
    required this.productType,
  }) {
    getAllProducts();
  }

  Future<void> getAllProducts() async {
    final result = await getAllIphonesUseCase(productType);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed load products...'),
            backgroundColor: (Colors.black12),
          ),
        );
      },
      (r) => state = state.copyWith(
        productList: r as List<IphoneProductEntity>,
      ),
    );
    notifyListeners();
  }

  void onAddProductButtonPress() async {
    await Navigator.pushNamed(context, AppNavigationNames.addProduct);
    getAllProducts();
  }
}

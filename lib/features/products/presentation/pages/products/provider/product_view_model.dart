import 'package:flutter/material.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/iphone_usecases/get_all_iphones_usecase.dart';

import '../../../../../../core/service/service_navigation.dart';

class ProductState {
  final List<IphoneProductEntity> productList;
  ProductState({
    required this.productList,
  });

  ProductState copyWith({
    List<IphoneProductEntity>? productList,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  final GetAllIphonesUseCase getAllIphonesUseCase;
  final BuildContext context;
  final ProductType productType;
  ProductState state = ProductState(productList: []);
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
      (right) => state = state.copyWith(
        productList: right,
      ),
    );
    notifyListeners();
  }

  void onAddProductButtonPress() async {
    await Navigator.pushNamed(context, AppNavigationNames.formForIphone);
    getAllProducts();
  }

  void onDetailProductButton(int index) async {
    await Navigator.of(context).pushNamed(AppNavigationNames.productDetail,
        arguments: {
          "id": state.productList[index].id,
          "type": state.productList[index].type
        });
    getAllProducts();
  }
}

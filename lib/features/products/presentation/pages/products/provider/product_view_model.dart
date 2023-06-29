import 'package:flutter/material.dart';

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/get_all_products_usecase.dart';

import '../../../../../../core/service/service_navigation.dart';

class _ProductState {
  final List<IphoneProductEntity> productList;
  final List<IphoneProductEntity?> searchList;
  final bool showSearch;
  _ProductState({
    required this.productList,
    this.searchList = const [],
    this.showSearch = false,
  });

  _ProductState copyWith({
    List<IphoneProductEntity>? productList,
    List<IphoneProductEntity?>? searchList,
    bool? showSearch,
  }) {
    return _ProductState(
      productList: productList ?? this.productList,
      searchList: searchList ?? this.searchList,
      showSearch: showSearch ?? this.showSearch,
    );
  }
}

class ProductViewModel extends ChangeNotifier {
  final GetAllProductsUseCase getAllProductsUseCase;
  final BuildContext context;
  _ProductState state = _ProductState(productList: []);
  ProductViewModel(this.getAllProductsUseCase, this.context) {
    getAllProducts();
  }

  Future<void> getAllProducts() async {
    final result =
        await getAllProductsUseCase.execute(ProductType.iphone.index);
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

  void onShowSearchBar() {
    state = state.copyWith(
        showSearch: !state.showSearch, searchList: state.productList);
    notifyListeners();
  }

  void onSearchProduct(String? value) {
    if (value != null) {
      final searchList = state.productList.where((e) {
        if (e.toString().toLowerCase().contains(value.toLowerCase()) ||
            e.condition.name.toLowerCase().contains(value.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();

      state =
          state.copyWith(searchList: searchList.isNotEmpty ? searchList : []);
    }
    notifyListeners();
  }
}

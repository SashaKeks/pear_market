// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pear_market/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/domain/repository/product_add_repository.dart';
import 'package:pear_market/domain/usecase/add_product_usecase.dart';

import '../../../../core/util/enums.dart';

class _AddProductState {
  final IphoneProductEntity product;
  final List<String> generationList;
  final List<String> colorList;
  final List<String> storageList;

  _AddProductState({
    required this.product,
    this.generationList = const [],
    this.colorList = const [],
    this.storageList = const [],
  });

  _AddProductState copyWith(
      {IphoneProductEntity? product,
      List<String>? generationList,
      List<String>? colorList,
      List<String>? storageList}) {
    return _AddProductState(
      product: product ?? this.product,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storageList: storageList ?? this.storageList,
    );
  }
}

class AddProductViewModel extends ChangeNotifier {
  final BuildContext context;
  final AddProductUseCase add;
  final ProductAddRepository repository;
  _AddProductState state = _AddProductState(
    product: IphoneProductEntity.empty(),
  );

  AddProductViewModel(this.context, this.add, this.repository) {
    getProductGeneration();
    getProductStorage();
  }

  Future<void> getProductGeneration() async {
    final result =
        await repository.getProductGeneration(state.product.type.name);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed load generations...'),
            backgroundColor: (Colors.black12),
          ),
        );
      },
      (right) {
        state = state.copyWith(
          generationList: right,
          product: state.product.copyWith(
            generation: right.last,
          ),
        );
      },
    );
    getProductColors(state.product.generation);
    notifyListeners();
  }

  Future<void> getProductColors(String generetion) async {
    final result =
        await repository.getProductColor(state.product.type.name, generetion);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed load colors...'),
            backgroundColor: (Colors.black12),
          ),
        );
      },
      (right) => state = state.copyWith(colorList: right),
    );
    notifyListeners();
  }

  Future<void> getProductStorage() async {
    final result = await repository.getProductStorage(state.product.type.name);
    result.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed load storages...'),
            backgroundColor: (Colors.black12),
          ),
        );
      },
      (right) => state = state.copyWith(storageList: right),
    );
    notifyListeners();
  }

  void addProduct() {}

  addProductType() {}
  addProductColor(String? color) {
    if (color != null) {
      state = state.copyWith(product: state.product.copyWith(color: color));
    }
  }

  addProductStatus() {}
  addProductBuyInfo() {}
  addProductStorage(String? storage) async {
    if (storage != null) {
      state = state.copyWith(
        product: state.product.copyWith(
          storage: storage,
        ),
      );
    }
  }

  addProductSellInfo() {}
  void addProductCondition(int? condition) {
    if (condition != null) {
      state = state.copyWith(
          product: state.product
              .copyWith(condition: ProductCondition.values[condition]));
    }
    notifyListeners();
  }

  addProductGeneration(String? generation) {
    if (generation != null) {
      state = state.copyWith(
        product: state.product.copyWith(generation: generation),
        colorList: [],
      );
      getProductColors(state.product.generation);
    }
  }

  addProductDescription() {}

  saveProduct() {
    add.execute(state.product);
  }
}

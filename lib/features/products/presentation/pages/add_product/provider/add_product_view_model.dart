// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';
import 'package:pear_market/features/products/domain/repository/product_parameters_repository.dart';
import 'package:pear_market/features/products/domain/usecase/product_base/add_product_usecase.dart';

import '../../../../../../core/util/enums.dart';

class _AddProductState {
  final IphoneProductEntity product;
  final List<String> generationList;
  final List<String> colorList;
  final List<String> storageList;
  final bool showExRateField;

  _AddProductState({
    required this.product,
    this.generationList = const [],
    this.colorList = const [],
    this.storageList = const [],
    this.showExRateField = false,
  });

  _AddProductState copyWith({
    IphoneProductEntity? product,
    List<String>? generationList,
    List<String>? colorList,
    List<String>? storageList,
    bool? showExRateField,
  }) {
    return _AddProductState(
      product: product ?? this.product,
      generationList: generationList ?? this.generationList,
      colorList: colorList ?? this.colorList,
      storageList: storageList ?? this.storageList,
      showExRateField: showExRateField ?? this.showExRateField,
    );
  }
}

class AddProductViewModel extends ChangeNotifier {
  final BuildContext context;
  final AddProductUseCase add;
  final ProductParametersRepository repository;
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
      (right) => state = state.copyWith(
        colorList: right,
        product: state.product.copyWith(
          color: right.last,
        ),
      ),
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
      (right) => state = state.copyWith(
        storageList: right,
        product: state.product.copyWith(
          storage: right.last,
        ),
      ),
    );
    notifyListeners();
  }

  void addProductColor(String? color) {
    if (color != null) {
      state = state.copyWith(product: state.product.copyWith(color: color));
    }
  }

  void addProductBuyPrice(String? price) {
    if (price != null) {
      state = state.copyWith(
          product:
              state.product.copyWith(buyPrice: double.tryParse(price) ?? 0));
    }
  }

  void addProductBuyCurrency(int? currency) {
    if (currency != null) {
      state = state.copyWith(
          product: state.product
              .copyWith(buyCurrency: ProductCurrency.values[currency]));
      if (ProductCurrency.values[currency] == ProductCurrency.UAH) {
        state = state.copyWith(showExRateField: false);
      } else {
        state = state.copyWith(showExRateField: true);
      }
    }

    notifyListeners();
  }

  void addProductBuyExRate(String? exRate) {
    if (exRate != null) {
      state = state.copyWith(
        product: state.product.copyWith(
          buyExRate: double.tryParse(exRate) ?? 1,
        ),
      );
    }
    notifyListeners();
  }

  void addProductStorage(String? storage) {
    if (storage != null) {
      state = state.copyWith(
        product: state.product.copyWith(
          storage: storage,
        ),
      );
    }
  }

  void addProductCondition(int? condition) {
    if (condition != null) {
      state = state.copyWith(
          product: state.product
              .copyWith(condition: ProductCondition.values[condition]));
    }
    notifyListeners();
  }

  void addProductGeneration(String? generation) {
    if (generation != null) {
      state = state.copyWith(
        product: state.product.copyWith(generation: generation),
        colorList: [],
      );
      getProductColors(state.product.generation);
    }
    notifyListeners();
  }

  void addProductDescription(String? description) {
    if (description != null) {
      state = state.copyWith(
        product: state.product.copyWith(description: description),
      );
      getProductColors(state.product.generation);
    }
    notifyListeners();
  }

  void saveProduct() {
    add.execute(state.product);
  }
}

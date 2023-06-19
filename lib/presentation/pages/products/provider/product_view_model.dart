// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pear_market/core/util/enums.dart';

import 'package:pear_market/domain/entities/iphone_product_entity.dart';

class _ProductState {
  final List<IphoneProductEntity> productList;

  _ProductState({
    required this.productList,
  });
}

class ProductViewModel extends ChangeNotifier {
  _ProductState _state = _ProductState(productList: []);
  _ProductState get state => _state;
}

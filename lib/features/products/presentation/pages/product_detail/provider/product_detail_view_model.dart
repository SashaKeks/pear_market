import 'package:flutter/foundation.dart';
import 'package:pear_market/core/util/enums.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ProductType productType;
  final String productId;

  ProductDetailViewModel({
    required this.productType,
    required this.productId,
  });
}

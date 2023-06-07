import 'package:pear_market/domain/entities/product_entity.dart';

import '../../core/util/enums.dart';

class IphoneProductEntity implements Product {
  final String? id;
  final String color;
  final String storage;
  final String buyInfo;
  final String sellInfo;
  final ProductType type;
  final String generation;
  final String description;
  final ProductStatus status;
  final ProductCondition condition;

  IphoneProductEntity({
    this.id,
    required this.type,
    required this.color,
    required this.status,
    required this.buyInfo,
    required this.storage,
    required this.sellInfo,
    required this.condition,
    required this.generation,
    required this.description,
  });
}

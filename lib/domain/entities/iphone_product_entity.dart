// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  factory IphoneProductEntity.empty() {
    return IphoneProductEntity(
      type: ProductType.iphone,
      color: "",
      status: ProductStatus.instock,
      buyInfo: "",
      storage: "",
      sellInfo: "",
      condition: ProductCondition.NEW,
      generation: "",
      description: "",
    );
  }

  IphoneProductEntity copyWith({
    String? id,
    String? color,
    String? storage,
    String? buyInfo,
    String? sellInfo,
    ProductType? type,
    String? generation,
    String? description,
    ProductStatus? status,
    ProductCondition? condition,
  }) {
    return IphoneProductEntity(
      id: id ?? this.id,
      color: color ?? this.color,
      storage: storage ?? this.storage,
      buyInfo: buyInfo ?? this.buyInfo,
      sellInfo: sellInfo ?? this.sellInfo,
      type: type ?? this.type,
      generation: generation ?? this.generation,
      description: description ?? this.description,
      status: status ?? this.status,
      condition: condition ?? this.condition,
    );
  }
}

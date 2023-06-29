// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

import '../../../../core/util/enums.dart';

class IphoneProductEntity extends Product {
  final String? id;
  final String color;
  final String storage;
  final double buyPrice;
  final ProductCurrency buyCurrency;
  final double buyExRate;
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
    required this.buyPrice,
    required this.buyCurrency,
    required this.buyExRate,
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
      buyPrice: 0,
      buyCurrency: ProductCurrency.UAH,
      buyExRate: 1,
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
    double? buyPrice,
    ProductCurrency? buyCurrency,
    double? buyExRate,
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
      buyPrice: buyPrice ?? this.buyPrice,
      buyCurrency: buyCurrency ?? this.buyCurrency,
      buyExRate: buyExRate ?? this.buyExRate,
      sellInfo: sellInfo ?? this.sellInfo,
      type: type ?? this.type,
      generation: generation ?? this.generation,
      description: description ?? this.description,
      status: status ?? this.status,
      condition: condition ?? this.condition,
    );
  }

  @override
  String toString() {
    return "$generation $storage $color";
  }
}

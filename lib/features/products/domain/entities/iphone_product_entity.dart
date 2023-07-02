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
  final DateTime buyDateTime;
  final double? sellPrice;
  final ProductCurrency sellCurrency;
  final double? sellExRate;
  final DateTime? sellDateTime;
  final ProductType type;
  final String generation;
  final String description;
  final ProductStatus status;
  final ProductCondition condition;

  IphoneProductEntity({
    this.id,
    this.sellPrice,
    this.sellCurrency = ProductCurrency.UAH,
    this.sellExRate = 1,
    this.sellDateTime,
    this.buyExRate = 1,
    required this.type,
    required this.color,
    required this.status,
    required this.buyPrice,
    required this.buyDateTime,
    this.buyCurrency = ProductCurrency.UAH,
    required this.storage,
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
      buyDateTime: DateTime.now(),
      storage: "",
      condition: ProductCondition.NEW,
      generation: "",
      description: "",
    );
  }

  @override
  String toString() {
    return "$generation $color $storage";
  }

  IphoneProductEntity copyWith({
    String? id,
    String? color,
    String? storage,
    double? buyPrice,
    ProductCurrency? buyCurrency,
    double? buyExRate,
    DateTime? buyDateTime,
    double? sellPrice,
    ProductCurrency? sellCurrency,
    double? sellExRate,
    DateTime? sellDateTime,
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
      buyDateTime: buyDateTime ?? this.buyDateTime,
      sellPrice: sellPrice ?? this.sellPrice,
      sellCurrency: sellCurrency ?? this.sellCurrency,
      sellExRate: sellExRate ?? this.sellExRate,
      sellDateTime: sellDateTime ?? this.sellDateTime,
      type: type ?? this.type,
      generation: generation ?? this.generation,
      description: description ?? this.description,
      status: status ?? this.status,
      condition: condition ?? this.condition,
    );
  }
}

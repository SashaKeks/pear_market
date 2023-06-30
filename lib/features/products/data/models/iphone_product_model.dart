import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';

class IphoneProductModel extends IphoneProductEntity {
  IphoneProductModel({
    super.id,
    required super.type,
    required super.color,
    required super.status,
    required super.buyPrice,
    required super.buyCurrency,
    required super.buyExRate,
    required super.storage,
    required super.sellInfo,
    required super.condition,
    required super.generation,
    required super.description,
  });

  factory IphoneProductModel.fromJson(Map<String, dynamic> json) {
    return IphoneProductModel(
      id: json["id"],
      type: ProductType.values[json["type"]],
      color: json["color"],
      status: ProductStatus.values[json["status"]],
      buyPrice: json["buyPrice"],
      buyCurrency: ProductCurrency.values[json["buyCurrency"]],
      buyExRate: json["buyPrice"],
      storage: json["storage"],
      sellInfo: json["sellInfo"],
      condition: ProductCondition.values[json["condition"]],
      generation: json["generation"],
      description: json["description"],
    );
  }
  factory IphoneProductModel.fromEntity(IphoneProductEntity entity) {
    return IphoneProductModel(
      id: entity.id,
      type: entity.type,
      color: entity.color,
      status: entity.status,
      buyPrice: entity.buyPrice,
      buyCurrency: entity.buyCurrency,
      buyExRate: entity.buyExRate,
      storage: entity.storage,
      sellInfo: entity.sellInfo,
      condition: entity.condition,
      generation: entity.generation,
      description: entity.description,
    );
  }
  IphoneProductEntity toEntity() {
    return IphoneProductEntity(
      id: id,
      type: type,
      color: color,
      status: status,
      buyPrice: buyPrice,
      buyCurrency: buyCurrency,
      buyExRate: buyExRate,
      storage: storage,
      sellInfo: sellInfo,
      condition: condition,
      generation: generation,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? '',
      "type": type.index,
      "color": color,
      "status": status.index,
      "buyPrice": buyPrice,
      "buyCurrency": buyCurrency.index,
      "buyExRate": buyExRate,
      "storage": storage,
      "sellInfo": sellInfo,
      "condition": condition.index,
      "generation": generation,
      "description": description,
    };
  }
}

import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/iphone_product_entity.dart';

class IphoneProductModel extends IphoneProductEntity {
  IphoneProductModel({
    super.id,
    super.sellPrice,
    super.sellCurrency,
    super.sellExRate,
    super.sellDateTime,
    super.buyExRate,
    required super.type,
    required super.color,
    required super.status,
    required super.buyPrice,
    required super.buyCurrency,
    required super.storage,
    required super.buyDateTime,
    required super.condition,
    required super.generation,
    required super.description,
  });

  factory IphoneProductModel.fromJson(Map<String, dynamic> json) {
    return IphoneProductModel(
      id: json["id"],
      sellPrice: json["sellPrice"],
      sellCurrency: ProductCurrency.values[json["sellCurrency"]],
      sellExRate: json["sellExRate"],
      sellDateTime: DateTime.tryParse(json["sellDateTime"]),
      type: ProductType.values[json["type"]],
      color: json["color"],
      status: ProductStatus.values[json["status"]],
      buyPrice: json["buyPrice"],
      buyCurrency: ProductCurrency.values[json["buyCurrency"]],
      buyExRate: json["buyExRate"],
      storage: json["storage"],
      buyDateTime:
          DateTime.tryParse(json["buyDateTime"]) ?? DateTime(1, 1, 1, 1, 00),
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
      buyDateTime: entity.buyDateTime,
      storage: entity.storage,
      sellPrice: entity.sellPrice,
      sellCurrency: entity.sellCurrency,
      sellExRate: entity.sellExRate,
      sellDateTime: entity.sellDateTime,
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
      buyDateTime: buyDateTime,
      storage: storage,
      sellPrice: sellPrice,
      sellCurrency: sellCurrency,
      sellExRate: sellExRate,
      sellDateTime: sellDateTime,
      condition: condition,
      generation: generation,
      description: description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type.index,
      "color": color,
      "status": status.index,
      "buyPrice": buyPrice,
      "buyCurrency": buyCurrency.index,
      "buyExRate": buyExRate,
      "buyDateTime": buyDateTime.toString(),
      "storage": storage,
      "sellPrice": sellPrice,
      "sellCurrency": sellCurrency.index,
      "sellExRate": sellExRate,
      "sellDateTime": sellDateTime.toString(),
      "condition": condition.index,
      "generation": generation,
      "description": description,
    };
  }
}

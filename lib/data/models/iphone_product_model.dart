import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/domain/entities/iphone_product_entity.dart';

class IphoneProductModel extends IphoneProductEntity {
  IphoneProductModel({
    required super.type,
    required super.color,
    required super.status,
    required super.buyInfo,
    required super.storage,
    required super.sellInfo,
    required super.condition,
    required super.generation,
    required super.description,
  });

  factory IphoneProductModel.fromJson(Map<String, dynamic> json) {
    return IphoneProductModel(
      type: ProductType.values[int.parse(json["type"])],
      color: json["color"],
      status: ProductStatus.values[int.parse(json["status"])],
      buyInfo: json["buyInfo"],
      storage: json["storage"],
      sellInfo: json["sellInfo"],
      condition: ProductCondition.values[int.parse(json["condition"])],
      generation: json["generation"],
      description: json["description"],
    );
  }
  factory IphoneProductModel.fromEntity(IphoneProductEntity entity) {
    return IphoneProductModel(
      type: entity.type,
      color: entity.color,
      status: entity.status,
      buyInfo: entity.buyInfo,
      storage: entity.storage,
      sellInfo: entity.sellInfo,
      condition: entity.condition,
      generation: entity.generation,
      description: entity.description,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type.index,
      "color": color,
      "status": status.index,
      "buyInfo": buyInfo,
      "storage": storage,
      "sellInfo": sellInfo,
      "condition": condition.index,
      "generation": generation,
      "description": description,
    };
  }
}

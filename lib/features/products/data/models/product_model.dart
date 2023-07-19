import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    super.sellPrice,
    super.sellCurrency,
    super.sellExRate,
    super.sellDateTime,
    super.buyExRate,
    required super.type,
    required super.ram,
    required super.proc,
    required super.video,
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      sellPrice: json["sellPrice"],
      sellCurrency: ProductCurrency.values[json["sellCurrency"]],
      sellExRate: json["sellExRate"],
      sellDateTime: json["sellDateTime"]?.toDate(),
      type: ProductType.values[json["type"]],
      color: json["color"],
      ram: json["ram"],
      proc: json["proc"],
      video: json["video"],
      status: ProductStatus.values[json["status"]],
      buyPrice: json["buyPrice"],
      buyCurrency: ProductCurrency.values[json["buyCurrency"]],
      buyExRate: json["buyExRate"],
      storage: json["storage"],
      buyDateTime: json["buyDateTime"].toDate(),
      condition: ProductCondition.values[json["condition"]],
      generation: json["generation"],
      description: json["description"],
    );
  }
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      type: entity.type,
      color: entity.color,
      ram: entity.ram,
      proc: entity.proc,
      video: entity.video,
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
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      type: type,
      color: color,
      ram: ram,
      proc: proc,
      video: video,
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
      "ram": ram,
      "proc": proc,
      "video": video,
      "status": status.index,
      "buyPrice": buyPrice,
      "buyCurrency": buyCurrency.index,
      "buyExRate": buyExRate,
      "buyDateTime": buyDateTime,
      "storage": storage,
      "sellPrice": sellPrice,
      "sellCurrency": sellCurrency.index,
      "sellExRate": sellExRate,
      "sellDateTime": sellDateTime,
      "condition": condition.index,
      "generation": generation,
      "description": description,
    };
  }
}

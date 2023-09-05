import 'package:pear_market/features/products/data/models/price_model.dart';
import 'package:pear_market/features/products/data/models/product_configuration_model.dart';
import 'package:pear_market/features/products/data/models/product_info_model.dart';
import 'package:pear_market/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    required super.productConfiguration,
    required super.sellPrice,
    required super.productInfo,
    required super.buyPrice,
    required super.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      productConfiguration: ProductConfigurationModel.fromJson(
        json["productConfiguration"],
      ),
      sellPrice: PriceModel.fromJson(
        json["sellPrice"],
      ),
      productInfo: ProductInfoModel.fromJson(json["productInfo"]),
      buyPrice: PriceModel.fromJson(
        json["buyPrice"],
      ),
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
    };
  }

  ProductModel copyModelWith({
    String? id,
    ProductConfigurationModel? productConfiguration,
    ProductInfoModel? productInfo,
    PriceModel? buyPrice,
    PriceModel? sellPrice,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productConfiguration: productConfiguration ?? this.productConfiguration,
      productInfo: productInfo ?? this.productInfo,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      description: description ?? this.description,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      productConfiguration:
          ProductConfigurationModel.fromEntity(entity.productConfiguration),
      sellPrice: PriceModel.fromEntity(entity.sellPrice),
      productInfo: ProductInfoModel.fromEntity(entity.productInfo),
      buyPrice: PriceModel.fromEntity(entity.buyPrice),
      description: entity.description,
    );
  }
}

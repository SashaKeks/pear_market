import 'package:pear_market/core/util/enums/product_condition_enum.dart';
import 'package:pear_market/core/util/enums/product_status_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/data/models/custom_user_for_product_model.dart';
import 'package:pear_market/features/products/domain/entities/product_info_entity.dart';

class ProductInfoModel extends ProductInfoEntity {
  const ProductInfoModel({
    required super.type,
    required super.owner,
    required super.whoCreate,
    required super.condition,
    required super.generation,
    super.status,
  });

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) {
    return ProductInfoModel(
      type: ProductTypeEnum.values[json["type"]],
      owner: CustomUserForProductModel.fromJson(json["owner"]),
      whoCreate: CustomUserForProductModel.fromJson(json["whoCreate"]),
      condition: ProductConditionEnum.values[json["condition"]],
      generation: json["generation"],
      status: ProductStatusEnum.values[json["status"]],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type.index,
      "owner": owner.userId,
      "whoCreate": whoCreate.userId,
      "condition": condition.index,
      "generation": generation,
      "status": status.index,
    };
  }

  factory ProductInfoModel.fromEntity(ProductInfoEntity infoEntity) {
    return ProductInfoModel(
      type: infoEntity.type,
      owner: infoEntity.owner,
      whoCreate: infoEntity.whoCreate,
      condition: infoEntity.condition,
      generation: infoEntity.generation,
      status: infoEntity.status,
    );
  }
}

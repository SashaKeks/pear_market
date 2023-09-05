import 'package:equatable/equatable.dart';
import 'package:pear_market/core/util/enums/product_condition_enum.dart';
import 'package:pear_market/core/util/enums/product_status_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/domain/entities/custom_user_for_product_entity.dart';

class ProductInfoEntity extends Equatable {
  const ProductInfoEntity({
    required this.type,
    required this.owner,
    required this.whoCreate,
    required this.condition,
    required this.generation,
    this.status = ProductStatusEnum.instock,
  });

  final CustomUserForProductEntity owner;
  final CustomUserForProductEntity whoCreate;
  final String generation;
  final ProductTypeEnum type;
  final ProductStatusEnum status;
  final ProductConditionEnum condition;

  factory ProductInfoEntity.empty() {
    return ProductInfoEntity(
      owner: CustomUserForProductEntity.empty(),
      whoCreate: CustomUserForProductEntity.empty(),
      generation: "",
      type: ProductTypeEnum.other,
      condition: ProductConditionEnum.NEW,
    );
  }
  @override
  List<Object?> get props =>
      [type, generation, condition, owner, status, whoCreate];

  ProductInfoEntity copyWith({
    CustomUserForProductEntity? owner,
    CustomUserForProductEntity? whoCreate,
    String? generation,
    ProductTypeEnum? type,
    ProductStatusEnum? status,
    ProductConditionEnum? condition,
  }) {
    return ProductInfoEntity(
      owner: owner ?? this.owner,
      whoCreate: whoCreate ?? this.whoCreate,
      generation: generation ?? this.generation,
      type: type ?? this.type,
      status: status ?? this.status,
      condition: condition ?? this.condition,
    );
  }
}

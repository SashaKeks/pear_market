import 'package:equatable/equatable.dart';
import 'package:pear_market/core/util/enums/product_condition_enum.dart';
import 'package:pear_market/core/util/enums/product_status_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';

class FilterProductEntity extends Equatable {
  final ProductTypeEnum? type;
  final String? generation;
  final String? color;
  final String? storage;
  final ProductStatusEnum? status;
  final ProductConditionEnum? condition;

  const FilterProductEntity({
    this.type,
    this.generation,
    this.status,
    this.color,
    this.storage,
    this.condition,
  });

  factory FilterProductEntity.empty() {
    return const FilterProductEntity(
      type: null,
      generation: null,
      status: null,
      color: null,
      storage: null,
      condition: null,
    );
  }

  @override
  List<Object?> get props => [
        type,
        generation,
        color,
        storage,
        status,
        condition,
      ];

  FilterProductEntity copyWith({
    ProductTypeEnum? Function()? type,
    String? Function()? generation,
    String? Function()? color,
    String? Function()? storage,
    ProductStatusEnum? Function()? status,
    ProductConditionEnum? Function()? condition,
  }) {
    return FilterProductEntity(
      type: type != null ? type() : this.type,
      generation: generation != null ? generation() : this.generation,
      color: color != null ? color() : this.color,
      status: status != null ? status() : this.status,
      storage: storage != null ? storage() : this.storage,
      condition: condition != null ? condition() : this.condition,
    );
  }
}

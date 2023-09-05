import 'package:equatable/equatable.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';

class GenerationEntity extends Equatable {
  final String name;
  final ProductTypeEnum? type;

  const GenerationEntity({
    this.type,
    required this.name,
  });

  GenerationEntity copyWith({
    String? name,
    ProductTypeEnum? type,
  }) {
    return GenerationEntity(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [name, type];
}

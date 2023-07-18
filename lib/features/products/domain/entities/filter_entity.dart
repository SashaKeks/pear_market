import 'package:pear_market/core/util/enums.dart';

class FilterEntity {
  final String? color;
  final String? storage;
  final String? generation;
  final String? version;
  final ProductCondition? condition;
  final ProductStatus? status;

  FilterEntity(
      {this.storage,
      this.generation,
      this.color,
      this.condition,
      this.version,
      this.status});

  Map<String, dynamic> toJson() {
    return {
      "storage": storage,
      "generation": generation,
      "color": color,
      "condition": condition?.index,
      "version": version,
      "status": status?.index
    };
  }

  FilterEntity copyWith({
    String? Function()? storage,
    String? Function()? generation,
    String? Function()? color,
    String? Function()? version,
    ProductCondition? Function()? condition,
    ProductStatus? Function()? status,
  }) {
    return FilterEntity(
      storage: storage != null ? storage() : this.storage,
      generation: generation != null ? generation() : this.generation,
      color: color != null ? color() : this.color,
      condition: condition != null ? condition() : this.condition,
      version: version != null ? version() : this.version,
      status: status != null ? status() : this.status,
    );
  }
}

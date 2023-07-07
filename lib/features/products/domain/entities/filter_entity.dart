import 'package:pear_market/core/util/enums.dart';

class FilterEntity {
  final String? color;
  final String? storage;
  final String? generation;
  final String? version;
  final ProductCondition? condition;

  FilterEntity(
      {this.storage,
      this.generation,
      this.color,
      this.condition,
      this.version});

  Map<String, dynamic> toJson() {
    return {
      "storage": storage,
      "generation": generation,
      "color": color,
      "condition": condition?.index,
      "version": version
    };
  }

  FilterEntity copyWith({
    String? storage,
    String? generation,
    String? color,
    String? version,
    ProductCondition? condition,
  }) {
    return FilterEntity(
      storage: storage ?? this.storage,
      generation: generation ?? this.generation,
      color: color == null
          ? this.color
          : color == ''
              ? null
              : color,
      condition: condition ?? this.condition,
      version: version ?? this.version,
    );
  }
}

import 'package:pear_market/features/products/domain/entities/product_configuration_entity.dart';

class ProductConfigurationModel extends ProductConfigurationEntity {
  const ProductConfigurationModel({
    required super.color,
    required super.storage,
    required super.ram,
    required super.proc,
    required super.video,
  });

  factory ProductConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ProductConfigurationModel(
      color: json["color"],
      storage: json["storage"],
      ram: json["ram"],
      proc: json["proc"],
      video: json["video"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "color": color,
      "storage": storage,
      "ram": ram,
      "proc": proc,
      "video": video,
    };
  }

  factory ProductConfigurationModel.fromEntity(
      ProductConfigurationEntity configurationEntity) {
    return ProductConfigurationModel(
      color: configurationEntity.color,
      storage: configurationEntity.storage,
      ram: configurationEntity.ram,
      proc: configurationEntity.proc,
      video: configurationEntity.video,
    );
  }
}

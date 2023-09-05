import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';

class GenerationModel extends GenerationEntity {
  const GenerationModel({required super.name});

  factory GenerationModel.fromJson(Map<String, dynamic> json) {
    return GenerationModel(name: json["name"]);
  }
}

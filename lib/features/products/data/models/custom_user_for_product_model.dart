import 'package:pear_market/features/products/domain/entities/custom_user_for_product_entity.dart';

class CustomUserForProductModel extends CustomUserForProductEntity {
  CustomUserForProductModel({
    required super.userId,
    required super.name,
    required super.surname,
  });

  factory CustomUserForProductModel.fromJson(Map<String, dynamic> json) {
    return CustomUserForProductModel(
      userId: json["userId"],
      name: json["name"],
      surname: json["surname"],
    );
  }
}

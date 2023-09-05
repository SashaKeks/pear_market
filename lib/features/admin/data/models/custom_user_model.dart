import 'package:pear_market/core/util/enums/access_enum.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';

class CustomUserModel extends CustomUserEntity {
  const CustomUserModel({
    super.id,
    required super.name,
    required super.surname,
    required super.phone,
    required super.email,
    required super.password,
    required super.access,
    super.isAuth,
  });

  factory CustomUserModel.fromEntity(CustomUserEntity entity) {
    return CustomUserModel(
      id: entity.id,
      name: entity.name,
      surname: entity.surname,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
      access: entity.access,
      isAuth: entity.isAuth,
    );
  }

  factory CustomUserModel.fromJson(Map<String, dynamic> json) {
    return CustomUserModel(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      access: AccessEnum.values[json["access"]],
      isAuth: json["isAuth"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "surname": surname,
      "phone": phone,
      "email": email,
      "password": password,
      "access": access.index,
      "isAuth": isAuth,
    };
  }

  @override
  CustomUserModel copyWith({
    String? id,
    String? name,
    String? surname,
    String? phone,
    String? email,
    String? password,
    AccessEnum? access,
    bool? isAuth,
  }) {
    return CustomUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      access: access ?? this.access,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:pear_market/core/util/enums/access_enum.dart';

class CustomUserEntity extends Equatable {
  const CustomUserEntity({
    this.id = "",
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.password,
    required this.access,
    this.isAuth = false,
  });
  final String id;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String password;
  final AccessEnum access;
  final bool isAuth;

  String get fullName => "$name $surname";

  factory CustomUserEntity.empty() {
    return const CustomUserEntity(
      name: "",
      surname: "",
      phone: "",
      email: "",
      password: "",
      access: AccessEnum.user,
      isAuth: false,
    );
  }

  CustomUserEntity copyWith({
    String? id,
    String? name,
    String? surname,
    String? phone,
    String? email,
    String? password,
    AccessEnum? access,
    bool? isAuth,
  }) {
    return CustomUserEntity(
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

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        phone,
        email,
        password,
        access,
        isAuth,
      ];
}

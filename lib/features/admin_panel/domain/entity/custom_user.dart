import 'package:equatable/equatable.dart';

class CustomUser extends Equatable {
  final String id;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String password;
  final Access access;
  final bool isAuth;

  const CustomUser(
      {this.id = "",
      required this.name,
      required this.surname,
      required this.phone,
      required this.email,
      required this.password,
      required this.access,
      this.isAuth = false});

  String get fullName => "$name $surname";
  factory CustomUser.empty() {
    return const CustomUser(
        name: "",
        surname: "",
        phone: "",
        email: "",
        password: "",
        access: Access.user,
        isAuth: false);
  }
  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        access: Access.values[json["access"]],
        isAuth: json["isAuth"]);
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

  CustomUser copyWith(
      {String? id,
      String? name,
      String? surname,
      String? phone,
      String? email,
      String? password,
      Access? access,
      bool? isAuth}) {
    return CustomUser(
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

enum Access { admin, user }

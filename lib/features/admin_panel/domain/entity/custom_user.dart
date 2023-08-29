class CustomUser {
  final String id;
  final String name;
  final String surname;
  final String phone;
  final String email;
  final String password;
  final Access access;

  CustomUser({
    this.id = "",
    required this.name,
    required this.surname,
    required this.phone,
    required this.email,
    required this.password,
    required this.access,
  });

  String get fullName => "$name $surname";

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      access: Access.values[json["access"]],
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
    };
  }

  CustomUser copyWith({
    String? id,
    String? name,
    String? surname,
    String? phone,
    String? email,
    String? password,
    Access? access,
  }) {
    return CustomUser(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      access: access ?? this.access,
    );
  }
}

enum Access { admin, user }

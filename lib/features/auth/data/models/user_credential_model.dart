import 'package:pear_market/features/auth/domain/entities/user_credentials_entity.dart';

class UserCredentialsModel extends UserCredentialsEntity {
  const UserCredentialsModel({required super.login, required super.password});

  factory UserCredentialsModel.fromEntity(UserCredentialsEntity entity) {
    return UserCredentialsModel(
      login: entity.login,
      password: entity.password,
    );
  }

  UserCredentialsEntity toEntity() {
    return UserCredentialsEntity(
      login: login,
      password: password,
    );
  }
}

import 'package:equatable/equatable.dart';

class UserCredentialsEntity extends Equatable {
  const UserCredentialsEntity({
    required this.login,
    required this.password,
  });

  final String login;
  final String password;

  factory UserCredentialsEntity.empty() {
    return const UserCredentialsEntity(
      login: "",
      password: "",
    );
  }
  @override
  List<Object?> get props => [login, password];

  UserCredentialsEntity copyWith({
    String? login,
    String? password,
  }) {
    return UserCredentialsEntity(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }
}

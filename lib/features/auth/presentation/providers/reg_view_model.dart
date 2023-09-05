import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/util/enums/access_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/usecase/create_user_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/update_user_usecase.dart';

class RegViewModel with ChangeNotifier {
  RegViewModel(
    this.userForUpdate,
    this._createUserUsecase,
    this._updateUserUsecase, {
    required this.context,
  }) {
    createdUser = userForUpdate ?? CustomUserEntity.empty();
  }
  //dependecy from admin for create user
  final CreateUserUsecase _createUserUsecase;
  //dependecy from admin for update user
  final UpdateUserUsecase _updateUserUsecase;

  final BuildContext context;
  final CustomUserEntity? userForUpdate;
  late CustomUserEntity createdUser;

  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  GlobalKey<FormState> get formKey => _formKey;

  void changeShowPasswordButtonPress() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void onChangeName(String? value) {
    if (value == null || value.isEmpty) return;
    createdUser = createdUser.copyWith(name: value);
  }

  void onChangeSurname(String? value) {
    if (value == null || value.isEmpty) return;
    createdUser = createdUser.copyWith(surname: value);
  }

  void onChangePhone(String? value) {
    if (value == null || value.isEmpty) return;
    createdUser = createdUser.copyWith(phone: value);
  }

  void onChangeEmail(String? value) {
    if (value == null || value.isEmpty) return;
    createdUser = createdUser.copyWith(email: value);
  }

  void onChangePassword(String? value) {
    if (value == null || value.isEmpty) return;
    createdUser = createdUser.copyWith(password: value);
  }

  void onChangeAccess(AccessEnum? value) {
    if (value == null) return;
    createdUser = createdUser.copyWith(access: value);
  }

  void onValidateButtonPress() {
    late final Future<Either<Failure, void>> result;
    if (_formKey.currentState!.validate()) {
      if (userForUpdate == null) {
        result = _createUserUsecase(params: createdUser);
      } else {
        result = _updateUserUsecase(params: createdUser);
      }
      Navigator.pop(context, result);
    } else {
      showSnackbarError(context, 'Incorrect data');
    }
  }
}

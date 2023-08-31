import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/create_user_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/update_user_usecase.dart';

class RegViewModel with ChangeNotifier {
  RegViewModel(
    this.userForUpdate,
    this._createUserUsecase,
    this._updateUserUsecase, {
    required this.context,
  }) {
    createdUser = userForUpdate ?? CustomUser.empty();
  }
  final CreateUserUsecase _createUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final BuildContext context;
  bool hidePassword = true;
  final CustomUser? userForUpdate;
  late CustomUser createdUser;
  final _formKey = GlobalKey<FormState>();
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

  void onChangeAccess(Access? value) {
    if (value == null) return;
    createdUser = createdUser.copyWith(access: value);
  }

  void onValidateButtonPress() {
    late final Future<Either<Failure, void>> result;
    if (_formKey.currentState!.validate()) {
      if (userForUpdate == null) {
        result = _createUserUsecase(createdUser);
      } else {
        result = _updateUserUsecase(createdUser);
      }
      Navigator.pop(context, result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text('Incorrect data'),
          action: SnackBarAction(
            textColor: Theme.of(context).primaryColorLight,
            label: 'Hide',
            onPressed: () {},
          ),
        ),
      );
    }
  }
}

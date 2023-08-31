import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/delete_user_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/get_all_users_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/update_user_usecase.dart';

class AdminPanelViewModel with ChangeNotifier {
  List<CustomUser> _userList = [];
  bool dataIsLoad = true;
  final GetAllUsersUsecase _getAllUsersUsecase;
  final DeleteUserUsecase _deleteUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final BuildContext context;
  AdminPanelViewModel(
    this._getAllUsersUsecase,
    this._deleteUserUsecase,
    this._updateUserUsecase, {
    required this.context,
  }) {
    getAllUsers();
  }
  final user = CustomUser(
    name: "name",
    surname: "surname",
    phone: "phone",
    email: "email@gmail.com",
    password: "password",
    access: Access.user,
    isAuth: false,
  );

  int get userCount => _userList.length;

  List<CustomUser> get userList => _userList;

  Future<void> getAllUsers() async {
    dataIsLoad = true;
    notifyListeners();
    final result = await _getAllUsersUsecase();
    result.fold((l) => print(l.errorMessage), (r) => _userList = r);
    dataIsLoad = false;
    notifyListeners();
  }

  Future<void> deleteUser(int index) async {
    final result = await _deleteUserUsecase(_userList[index]);
    result.fold((l) => print(l.errorMessage), (_) {});
    getAllUsers();
    notifyListeners();
  }

  Future<void> createUser() async {
    final result =
        (await Navigator.pushNamed(context, AppNavigationNames.regPage))
            as Either<Failure, void>?;
    result?.fold((l) => print(l.errorMessage), (_) {});
    getAllUsers();
    notifyListeners();
  }

  Future<void> updateUser(int index) async {
    await Navigator.pushNamed(
      context,
      AppNavigationNames.regPage,
      arguments: userList[index],
    );
  }

  Future<void> openUserDetail() async {}
}

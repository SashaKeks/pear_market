import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/core/util/enums/data_status_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:pear_market/features/admin/domain/usecase/delete_user_usecase.dart';
import 'package:pear_market/features/admin/domain/usecase/get_all_users_usecase.dart';

class AdminPanelViewModel with ChangeNotifier {
  AdminPanelViewModel(
    this._getAllUsersUsecase,
    this._deleteUserUsecase, {
    required this.context,
  }) {
    getAllUsers();
  }
  final GetAllUsersUsecase _getAllUsersUsecase;
  final DeleteUserUsecase _deleteUserUsecase;
  final BuildContext context;

  List<CustomUserEntity> _userList = [];
  DataStatusEnum dataIsLoad = DataStatusEnum.none;

  int get userCount => _userList.length;

  List<CustomUserEntity> get userList => _userList;

  Future<void> getAllUsers() async {
    dataIsLoad = DataStatusEnum.progress;
    notifyListeners();
    final result = await _getAllUsersUsecase();
    result.fold(
      (failure) => showSnackbarError(context, failure.errorMessage),
      (result) {
        _userList = result;
        dataIsLoad = DataStatusEnum.success;
      },
    );
    dataIsLoad = DataStatusEnum.none;
    notifyListeners();
  }

  Future<void> deleteUser(int index) async {
    final result = await _deleteUserUsecase(params: _userList[index]);
    result.fold(
        (failure) => showSnackbarError(context, failure.errorMessage), (_) {});
    getAllUsers();
  }

  Future<void> createUser() async {
    final result =
        (await Navigator.pushNamed(context, AppNavigationNames.regPage))
            as Either<Failure, void>?;
    result?.fold(
        (failure) => showSnackbarError(context, failure.errorMessage), (_) {});
    getAllUsers();
  }

  Future<void> updateUser(int index) async {
    await Navigator.pushNamed(
      context,
      AppNavigationNames.regPage,
      arguments: userList[index],
    );
    getAllUsers();
  }

  Future<void> openUserDetail() async {}
}

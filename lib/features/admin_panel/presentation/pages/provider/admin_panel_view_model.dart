import 'package:flutter/foundation.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/create_user_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/delete_user_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/get_all_users_usecase.dart';
import 'package:pear_market/features/admin_panel/domain/usecase/update_user_usecase.dart';

class AdminPanelViewModel with ChangeNotifier {
  List<CustomUser> _userList = [];
  bool dataIsLoad = true;
  final GetAllUsersUsecase _getAllUsersUsecase;
  final DeleteUserUsecase _deleteUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final CreateUserUsecase _createUserUsecase;
  AdminPanelViewModel(
    this._getAllUsersUsecase,
    this._createUserUsecase,
    this._deleteUserUsecase,
    this._updateUserUsecase,
  ) {
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
    print("delete user");
  }

  Future<void> createUser() async {
    final result = await _createUserUsecase(user);
    result.fold((l) => print(l.errorMessage), (_) {});
    print('create user');
    getAllUsers();
    notifyListeners();
  }

  Future<void> updateUser(int index) async {
    _updateUserUsecase(userList[index]);
    print('edit user $index');
  }

  Future<void> openUserDetail() async {}
}

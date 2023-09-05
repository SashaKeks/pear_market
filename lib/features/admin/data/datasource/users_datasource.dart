import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/features/admin/data/models/custom_user_model.dart';

class UsersDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection(AppConstants.usersDB);

  Future<void> createUser(CustomUserModel user) async {
    final userWithEmail =
        await _users.where("email", isEqualTo: user.email).get();

    if (userWithEmail.docs.isNotEmpty) {
      throw ServerUserWithSuchEmailAlreadyExist();
    }
    final result = await _users.add(user.toJson());
    await updateUser(user.copyWith(id: result.id));
  }

  Future<void> deleteUser(CustomUserModel user) async {
    await _users.doc(user.id).delete();
  }

  Future<List<CustomUserModel>> getAllUsers() {
    final result = _users.where("access", isNotEqualTo: 0).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          return value.docs
              .map(
                (e) =>
                    CustomUserModel.fromJson(e.data() as Map<String, dynamic>),
              )
              .toList();
        } else {
          throw ServerNotFoundException();
        }
      },
    );
    return result;
  }

  Future<void> updateUser(CustomUserModel newUser) async {
    await _users.doc(newUser.id).update(newUser.toJson());
  }

  Future<CustomUserModel> getUserById(String userId) async {
    return _users.doc(userId).get().then((value) =>
        CustomUserModel.fromJson(value.data() as Map<String, dynamic>));
  }
}

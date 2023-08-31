import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';

import '../../domain/entity/custom_user.dart';

class UsersDataSource {
  Future<void> createUser(CustomUser user) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);
    final userWithSuchEmail =
        await users.where("email", isEqualTo: user.email).get();
    if (userWithSuchEmail.docs.isNotEmpty) {
      throw ServerFailure("User with such email is already exist");
    }
    final result = await users.add(user.toJson());
    await updateUser(user.copyWith(id: result.id));
  }

  Future<void> deleteUser(CustomUser user) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);
    await users.doc(user.id).delete();
  }

  Future<List<CustomUser>> getAllUsers() {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);
    final result = users.where("access", isNotEqualTo: 0).get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          return value.docs
              .map(
                (e) => CustomUser.fromJson(e.data() as Map<String, dynamic>),
              )
              .toList();
        } else {
          return <CustomUser>[];
        }
      },
    );
    return result;
  }

  Future<void> updateUser(CustomUser newUser) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);

    await users.doc(newUser.id).update(newUser.toJson());
  }
}

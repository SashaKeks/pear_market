import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/service/user_access_service.dart';
import 'package:pear_market/features/auth/data/models/user_credential_model.dart';

class AuthRemoteDataSource {
  final UserAccessService _service;
  AuthRemoteDataSource(this._service);

  Future<void> signIn({required UserCredentialsModel credentials}) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);

    final userWithSuchEmail =
        await users.where("email", isEqualTo: credentials.login).get();

    if (userWithSuchEmail.docs.isEmpty) {
      throw ServerNotFoundException();
    }

    final currentUser =
        userWithSuchEmail.docs.first.data() as Map<String, dynamic>;

    if (credentials.password == currentUser["password"]) {
      final currentUserId = currentUser["id"];
      await users.doc(currentUserId).update({"isAuth": true});
      _service.setCurrentUser(currentUserId);
    } else {
      throw ServerIncorrectUserPassword();
    }
  }

  Future<void> signOut() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);
    final currentUser = await _service.currentUser();
    if (currentUser != null) {
      await users.doc(currentUser.id).update({"isAuth": false});
    } else {
      throw ServerNotFoundException();
    }
  }
}

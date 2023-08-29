import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  CustomUser? currentUser;
  @override
  Future<Either<Failure, CustomUser?>> signIn({
    required String login,
    required String password,
  }) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);

    final userWithSuchEmail =
        await users.where("email", isEqualTo: login).get();

    if (userWithSuchEmail.docs.isEmpty) {
      throw ServerFailure("User not found");
    }

    currentUser = CustomUser.fromJson(
        userWithSuchEmail.docs.first.data() as Map<String, dynamic>);
    if (password == currentUser!.password) {
      await users.doc(currentUser!.id).update({"isAuth": true});
      return right(currentUser!.copyWith(isAuth: true));
    } else {
      return left(ServerFailure("Wrong password provided for that user"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);

    if (currentUser != null) {
      await users.doc(currentUser!.id).update({"isAuth": false});
      return right(null);
    } else {
      return left(ServerFailure("Auth user not found"));
    }
  }
}

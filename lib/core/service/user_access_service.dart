import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums/access_enum.dart';
import 'package:pear_market/features/admin/data/models/custom_user_model.dart';
import 'package:pear_market/features/admin/domain/entity/custom_user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccessService {
  CustomUserEntity? _user;
  UserAccessService() {
    initCurrentUser();
  }

  Future<void> initCurrentUser() async {
    _user = await currentUser();
  }

  Future<SharedPreferences> _getPrefs() async =>
      await SharedPreferences.getInstance();

  bool get showAdminPanelAccess => [AccessEnum.admin].contains(_user?.access);

  bool get addProductAccess =>
      [AccessEnum.admin, AccessEnum.user].contains(_user?.access);

  bool get canSeeProductOwner => [AccessEnum.admin].contains(_user?.access);

  bool get canDeleteGenerationFromFilter =>
      [AccessEnum.admin].contains(_user?.access);

  Future<CustomUserEntity?> currentUser() async {
    final pref = await _getPrefs();
    final currentUserId = pref.getString(AppConstants.currentUserIdKey);

    CollectionReference users =
        FirebaseFirestore.instance.collection(AppConstants.usersDB);

    final userWithSuchEmail =
        await users.where("id", isEqualTo: currentUserId).get();

    final currentUser =
        userWithSuchEmail.docs.first.data() as Map<String, dynamic>;

    return CustomUserModel.fromJson(currentUser);
  }

  Future<void> setCurrentUser(String currentUserId) async {
    final pref = await _getPrefs();
    pref.setString(AppConstants.currentUserIdKey, currentUserId);
  }
}

///todo: 
/// 2) credit product for you to magasine or for buyer to you
/// 3) product must have a (owner -> done)and person who create
/// 4) transfer product to another user
/// 5) add to filter wrapping by owner for admin
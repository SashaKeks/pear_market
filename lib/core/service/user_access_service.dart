import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';

class UserAccessService {
  CustomUser? _user;
  UserAccessService([this._user]);

  set userSet(CustomUser user) {
    _user = user;
  }

  CustomUser? get userGet => _user;
  bool get showAdminPanelAccess => [Access.admin].contains(_user?.access);

  bool get addProductAccess =>
      [Access.admin, Access.user].contains(_user?.access);

  bool get canSeeProductOwner => [Access.admin].contains(_user?.access);

  bool get canDeleteGenerationFromFilter =>
      [Access.admin].contains(_user?.access);
}

///todo: 
/// 2) credit product for you to magasine or for buyer to you
/// 3) product must have a (owner -> done)and person who create
/// 4) transfer product to another user
/// 5) add to filter wrapping by owner for admin
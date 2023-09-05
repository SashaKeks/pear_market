import 'package:flutter/material.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/core/service/user_access_service.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';

class MenuViewModel extends ChangeNotifier {
  MenuViewModel(
    this._context,
    this.userAccessService,
    this.signOutUseCase,
  );

  //dependency from auth feature
  final SignOutUseCase signOutUseCase;
  //dependency from access service
  final UserAccessService userAccessService;

  final BuildContext _context;

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  List<String> get titleList =>
      const <String>['MENU', 'STATISTIC', "INFO", "ADMIN PANEL"];
  String getImagePath(int index) {
    return "assets/images/${ProductTypeEnum.values[index].name}.png";
  }

  void onMenuItemTap(int index) {
    Navigator.of(_context).pushNamed(
      AppNavigationNames.subMenu,
      arguments: ProductTypeEnum.values[index],
    );
  }

  void onSignOutButonPress() async {
    final result = await signOutUseCase();
    result.fold(
      (l) => showSnackbarError(_context, l.errorMessage),
      (_) => Navigator.pushNamedAndRemoveUntil(
          _context, AppNavigationNames.authPage, (route) => false),
    );
  }

  void onChangePage(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}

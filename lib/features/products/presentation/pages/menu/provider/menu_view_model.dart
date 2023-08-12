import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';

class MenuViewModel extends ChangeNotifier {
  final SignOutUseCase signOutUseCase;
  final BuildContext context;
  MenuViewModel(this.context, {required this.signOutUseCase}) {}

  void onMenuItemTap(int index) async {
    await Navigator.of(context).pushNamed(
      AppNavigationNames.productList,
      arguments: ProductType.values[index],
    );
  }

  void onSignOutButonPress() {
    signOutUseCase();
    Navigator.pushNamedAndRemoveUntil(
        context, AppNavigationNames.authPage, (route) => false);
  }

  void onThemeSwitcher() {}
}

import 'package:flutter/material.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/auth/domain/usecase/sign_out_usecase.dart';

class MenuViewModel extends ChangeNotifier {
  final SignOutUseCase signOutUseCase;
  final BuildContext context;
  MenuViewModel(
    this.context, {
    required this.signOutUseCase,
  });

  Future<void> onMenuItemTap(int index) async {
    if (ProductType.values[index] == ProductType.other) {
      await Navigator.of(context).pushNamed(
        AppNavigationNames.productList,
        arguments: ProductType.values[index],
      );
    } else {
      await Navigator.of(context).pushNamed(
        AppNavigationNames.subMenu,
        arguments: ProductType.values[index],
      );
    }
  }

  void onSignOutButonPress() async {
    final result = await signOutUseCase();
    result.fold((l) => print(l.errorMessage), (_) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppNavigationNames.authPage, (route) => false);
    });
  }

  void onThemeSwitcher() {}
}

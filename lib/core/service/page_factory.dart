import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/features/admin_panel/presentation/pages/admin_panel_page.dart';
import 'package:pear_market/features/admin_panel/presentation/pages/provider/admin_panel_view_model.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

class PageFactory {
  static Widget createAdminPanel() {
    return ChangeNotifierProvider(
      create: (context) =>
          AdminPanelViewModel(getIt(), getIt(), context: context),
      child: const AdminPanelPage(),
    );
  }
}

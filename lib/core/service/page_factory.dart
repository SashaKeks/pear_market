import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pear_market/features/admin/presentation/pages/admin_screen.dart';
import 'package:pear_market/features/admin/presentation/providers/admin_panel_view_model.dart';
import 'package:pear_market/features/info/presentation/pages/info_screen.dart';
import 'package:pear_market/features/info/presentation/providers/info_view_model.dart';
import 'package:pear_market/features/statistic/presentation/pages/statistic_screen.dart';
import 'package:pear_market/features/statistic/presentation/providers/statistic_view_model.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

class PageFactory {
  static Widget createAdminPanel() {
    return ChangeNotifierProvider(
      create: (context) =>
          AdminPanelViewModel(getIt(), getIt(), context: context),
      child: const AdminScreen(),
    );
  }

  static Widget createInfoScreen() {
    return ChangeNotifierProvider(
      create: (context) => InfoViewModel(),
      child: const InfoScreen(),
    );
  }

  static Widget createStatisticScreen() {
    return ChangeNotifierProvider(
      create: (context) => StatisticViewModel(),
      child: const StatisticScreen(),
    );
  }
}

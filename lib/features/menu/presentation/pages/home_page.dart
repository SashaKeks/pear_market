import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/colors.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/service/page_factory.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/info/presentation/pages/info_screen.dart';
import 'package:pear_market/features/menu/presentation/pages/menu_screen.dart';
import 'package:pear_market/features/statistic/presentation/pages/statistic_screen.dart';
import 'package:pear_market/features/menu/presentation/provider/menu_view_model.dart';
import 'package:pear_market/features/menu/presentation/widgets/theme_mode_switcher.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final pages = <Widget>[
    const MenuScreen(),
    const StatisticScreen(),
    const InfoScreen(),
    PageFactory.createAdminPanel(),
  ];

  @override
  Widget build(BuildContext context) {
    final stateWatch = context.watch<MenuViewModel>();
    final stateRead = context.read<MenuViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(stateWatch.titleList[stateWatch.currentPageIndex]),
        centerTitle: true,
        leading: const ThemeModeSwitcher(),
        actions: [
          IconButton(
            onPressed: stateRead.onSignOutButonPress,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: pages[stateWatch.currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        fixedColor: AppColors.bottomMenuItemFixedColor,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        currentIndex: stateWatch.currentPageIndex,
        onTap: stateRead.onChangePage,
        items: bottomNavigationBarItems(
          stateWatch.userAccessService.showAdminPanelAccess,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems(bool isAdmin) {
    if (isAdmin) {
      return const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Statistic",
          icon: Icon(Icons.stacked_line_chart),
        ),
        BottomNavigationBarItem(
          label: "Info",
          icon: Icon(Icons.info_outline),
        ),
        BottomNavigationBarItem(
          label: "Admin",
          icon: Icon(Icons.all_inclusive_sharp),
        ),
      ];
    } else {
      return const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Statistic",
          icon: Icon(Icons.stacked_line_chart),
        ),
        BottomNavigationBarItem(
          label: "Info",
          icon: Icon(Icons.info_outline),
        ),
      ];
    }
  }
}

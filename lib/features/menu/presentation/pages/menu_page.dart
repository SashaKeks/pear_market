import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/service/page_factory.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/main_app/presentation/provider/main_view_model.dart';
import 'package:pear_market/features/menu/presentation/provider/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentPageIndex = 0;
  final pages = <Widget>[
    const TypeMenu(),
    const Placeholder(),
    const Placeholder(),
    PageFactory.createAdminPanel(),
  ];

  final titles = const <String>['MENU', 'STATISTIC', "INFO", "ADMIN PANEL"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentPageIndex]),
        centerTitle: true,
        leading: const ThemeModeSwitcher(),
        actions: [
          IconButton(
            onPressed: context.read<MenuViewModel>().onSignOutButonPress,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        currentIndex: currentPageIndex,
        onTap: (value) => setState(() {
          currentPageIndex = value;
        }),
        items: const [
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
        ],
      ),
    );
  }
}

class TypeMenu extends StatelessWidget {
  const TypeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppDemensions.appSize10,
          ),
          Wrap(
            children: List.generate(
              ProductType.values.length,
              (index) => MenuItem(index: index),
            ),
          )
        ],
      ),
    );
  }
}

class ThemeModeSwitcher extends StatelessWidget {
  const ThemeModeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.read<MainViewModel>().changeThemeMode,
      icon: Icon(context.watch<MainViewModel>().isDark
          ? Icons.light_mode
          : Icons.dark_mode),
    );
  }
}

class MenuItem extends StatelessWidget {
  final int index;
  const MenuItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDemensions.appSize10,
          vertical: AppDemensions.appSize5),
      child: InkWell(
        onTap: () => context.read<MenuViewModel>().onMenuItemTap(index),
        child: Container(
          // padding: EdgeInsets.all(AppDemensions.appSize5),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppDemensions.appSize150,
                // width: AppDemensions.appSize200,
                child: Image.asset(
                  "assets/images/${ProductType.values[index].name}.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                ProductType.values[index].name.toUpperCase(),
                style: GoogleFonts.nanumGothic(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/loader/presentation/provider/main_view_model.dart';
import 'package:pear_market/features/menu/presentation/provider/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MENU"),
        centerTitle: true,
        actions: [
          const ThemeModeSwitcher(),
          IconButton(
            onPressed: context.read<MenuViewModel>().onSignOutButonPress,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColorLight,
        unselectedItemColor: Theme.of(context).primaryColorDark,
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

class ThemeModeSwitcher extends StatelessWidget {
  const ThemeModeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, state, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.light_mode),
          Switch(
            value: state.isDark,
            activeColor: Theme.of(context).primaryColorLight,
            inactiveThumbColor: Theme.of(context).primaryColorLight,
            onChanged: state.changeThemeMode,
          ),
          const Icon(Icons.dark_mode),
          SizedBox(width: AppDemensions.appSize5),
        ],
      ),
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
              Container(
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
                  textStyle: TextStyle(
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

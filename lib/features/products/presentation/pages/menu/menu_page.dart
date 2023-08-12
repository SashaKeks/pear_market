import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/menu/provider/menu_view_model.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.light_mode),
              Switch(
                // This bool value toggles the switch.
                value: true,
                activeColor: Theme.of(context).primaryColorLight,
                inactiveThumbColor: Theme.of(context).primaryColorLight,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  // setState(() {
                  //   light = value;
                  // });
                },
              ),
              Icon(Icons.dark_mode),
              SizedBox(width: AppDemensions.appSize5),
            ],
          ),
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
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDemensions.appSize10,
                      vertical: AppDemensions.appSize5),
                  child: InkWell(
                    onTap: () =>
                        context.read<MenuViewModel>().onMenuItemTap(index),
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
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,
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

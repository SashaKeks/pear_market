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
          IconButton(
            onPressed: context.read<MenuViewModel>().onSignOutButonPress,
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Wrap(
                children: List.generate(
                  ProductType.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.all(AppDemensions.appSize10),
                    child: InkWell(
                      onTap: () =>
                          context.read<MenuViewModel>().onMenuItemTap(index),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: AppDemensions.appSize150,
                            height: AppDemensions.appSize150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/${ProductType.values[index].name}.png",
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ProductType.values[index].name.toUpperCase(),
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: AppDemensions.appSize10,
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
        backgroundColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.deepPurple[200],
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/menu/provider/menu_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/chart_widget.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MENU"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                  height: AppDemensions.appSize300,
                  child: ChangeNotifierProvider.value(
                    value: Provider.of<MenuViewModel>(context),
                    child: const BarChartMoney(),
                  )),
            ),
            Divider(
              thickness: AppDemensions.appSize5,
            ),
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
                            width: AppDemensions.appSize100,
                            height: AppDemensions.appSize100,
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
    );
  }
}

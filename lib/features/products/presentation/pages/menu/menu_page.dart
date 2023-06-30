import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';

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
              child: Container(
                height: AppDemensions.appSize300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/10017/10017625.png",
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: AppDemensions.appSize5,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: AppDemensions.appSize3,
              padding: EdgeInsets.all(AppDemensions.appSize10),
              children: List.generate(
                ProductType.values.length,
                (index) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppNavigationNames.productList,
                      arguments: ProductType.values[index],
                    );
                  },
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
                                    "assets/images/${ProductType.values[index].name}.png"))),
                      ),
                      Text(
                        ProductType.values[index].name.toUpperCase(),
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

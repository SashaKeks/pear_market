import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/colors.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/service/service_navigation.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(AppDemensions.appSize20),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(AppDemensions.appSize10),
                color: AppColors.productCardColor,
                child: Column(
                  children: [
                    Container(
                      height: AppDemensions.appSize150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/iphone_14_pro_max.png'),
                        ),
                      ),
                    ),
                    Text(
                      "iPhone 14 Pro Max 256GB Deep Purple",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontSize: AppDemensions.appSize25,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'SOLD',
                          style: GoogleFonts.acme(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) => SizedBox(
            height: AppDemensions.appSize20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppNavigationNames.addProduct);
        },
        child: Icon(
          Icons.add,
          size: AppDemensions.appSize25,
        ),
      ),
    );
  }
}

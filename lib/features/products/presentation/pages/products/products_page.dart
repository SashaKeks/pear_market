import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/colors.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            context.watch<ProductViewModel>().productType.name.toUpperCase()),
      ),
      body: Container(
        padding: EdgeInsets.all(AppDemensions.appSize20),
        child: ListView.separated(
          itemCount: context.watch<ProductViewModel>().state.productList.length,
          itemBuilder: ((context, index) {
            final product =
                context.watch<ProductViewModel>().state.productList[index];
            return InkWell(
              onTap: () =>
                  context.read<ProductViewModel>().onDetailProductButton(index),
              child: Container(
                padding: EdgeInsets.all(AppDemensions.appSize10),
                color: AppColors.productCardColor,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(AppDemensions.appSize5),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text(
                              product.condition.name,
                              style: GoogleFonts.acme(
                                textStyle: TextStyle(
                                  fontSize: AppDemensions.appSize25,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: AppDemensions.appSize150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/${product.type.name}.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      product.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: AppDemensions.appSize20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    context
                                .watch<ProductViewModel>()
                                .state
                                .productList[index]
                                .status ==
                            ProductStatus.instock
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => context
                                  .read<ProductViewModel>()
                                  .onSellButtonPress(index),
                              child: Text(
                                'SELL',
                                style: GoogleFonts.montserrat(
                                  fontSize: AppDemensions.appSize20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "DAYS: ${(context.watch<ProductViewModel>().state.productList[index].sellDateTime ?? DateTime.now()).difference(context.watch<ProductViewModel>().state.productList[index].buyDateTime).inDays}",
                                style: GoogleFonts.montserrat(
                                  fontSize: AppDemensions.appSize20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ((context
                                                .watch<ProductViewModel>()
                                                .state
                                                .productList[index]
                                                .sellPrice ??
                                            0) -
                                        context
                                            .watch<ProductViewModel>()
                                            .state
                                            .productList[index]
                                            .buyPrice)
                                    .toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: AppDemensions.appSize20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
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
        onPressed: context.read<ProductViewModel>().onAddProductButtonPress,
        child: Icon(
          Icons.add,
          size: AppDemensions.appSize25,
        ),
      ),
    );
  }
}

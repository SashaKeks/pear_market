import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/provider/product_detail_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context
              .watch<ProductDetailViewModel>()
              .productType
              .name
              .toUpperCase(),
        ),
        actions: [
          IconButton(
              onPressed:
                  context.read<ProductDetailViewModel>().onEditButtonPress,
              icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
            ),
            items: [1, 2, 3].map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/iphone2.png",
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            padding: EdgeInsets.all(AppDemensions.appSize5),
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text(
                              context
                                  .watch<ProductDetailViewModel>()
                                  .state
                                  .iphoneProduct
                                  .condition
                                  .name,
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
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
          const Divider(),
          Text(
            context
                .watch<ProductDetailViewModel>()
                .state
                .iphoneProduct
                .generation,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: AppDemensions.appSize25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: AppDemensions.appSize20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Some"),
              Text("data"),
            ],
          ),
          Divider(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed:
                  context.read<ProductDetailViewModel>().onSellButtonPress,
              child: Text(context
                          .watch<ProductDetailViewModel>()
                          .state
                          .iphoneProduct
                          .status ==
                      ProductStatus.sold
                  ? "Un Sell"
                  : "Sell"),
            ),
            ElevatedButton(
              onPressed:
                  context.read<ProductDetailViewModel>().onDeleteButtonPress,
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

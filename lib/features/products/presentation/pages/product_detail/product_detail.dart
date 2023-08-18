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
    final product = context.watch<ProductDetailViewModel>().state.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context
              .watch<ProductDetailViewModel>()
              .productType
              .name
              .toUpperCase(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed:
                  context.read<ProductDetailViewModel>().onEditButtonPress,
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                ),
                items: [1, 2].map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/${context.watch<ProductDetailViewModel>().state.product.type.name}.png",
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
                                      .product
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
                    .product
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
              const Divider(
                color: Colors.black,
              ),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDemensions.appSize20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.description,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: AppDemensions.appSize20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: AppDemensions.appSize20,
              ),
              DetailTableView(
                tableName: "Color:",
                data: product.color,
              ),
              DetailTableView(
                tableName: "Storage:",
                data: product.storage,
              ),
              DetailTableView(
                tableName: "Ram:",
                data: product.ram,
              ),
              DetailTableView(
                tableName: "Processor:",
                data: product.proc,
              ),
              DetailTableView(
                tableName: "Video Card:",
                data: product.video,
              ),
              DetailTableView(
                tableName: "Status:",
                data: product.status.name.toUpperCase(),
                style: TextStyle(
                    fontSize: AppDemensions.appSize20,
                    color: product.status == ProductStatus.sold
                        ? Colors.green[800]
                        : Colors.red[800]),
              ),
              DetailTableView(
                tableName: "Buy Price:",
                data: "${product.buyPrice} ${product.buyCurrency.name}",
              ),
              DetailTableView(
                tableName: "Sell Price:",
                data: product.sellPrice == null
                    ? null
                    : "${product.sellPrice} ${product.sellCurrency.name}",
              ),
              DetailTableView(
                tableName: "Days Count:",
                data: product.getDateTimeDiference.toString(),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: product.status == ProductStatus.sold
                      ? null
                      : context
                          .read<ProductDetailViewModel>()
                          .onSellButtonPress,
                  child: Text(
                    "Sell",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: AppDemensions.appSize20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: context
                      .read<ProductDetailViewModel>()
                      .onDeleteButtonPress,
                  child: Text(
                    "Delete",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: AppDemensions.appSize20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

class DetailTableView extends StatelessWidget {
  final String tableName;
  final String? data;
  final TextStyle? style;
  const DetailTableView({
    required this.data,
    required this.tableName,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tableName,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: AppDemensions.appSize20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                data!,
                style: style,
              ),
            ],
          ),
          const Divider(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

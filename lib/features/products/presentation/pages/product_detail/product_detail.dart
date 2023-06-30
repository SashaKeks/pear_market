import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pear_market/features/products/presentation/pages/product_detail/provider/product_detail_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<ProductDetailViewModel>().productId),
      ),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1,
              enlargeCenterPage: true,
            ),
            items: [1, 2, 3].map(
              (i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/iphone2.png",
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            'Photo 1',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
          Text("Iphone 12 pro max"),
        ],
      ),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Sell"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/colors.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: context.watch<ProductViewModel>().state.showSearch
              ? TextField(
                  autofocus: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: "Search",
                    labelStyle: GoogleFonts.acme(
                        textStyle: const TextStyle(color: Colors.white)),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: GoogleFonts.acme(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: context.read<ProductViewModel>().onSearchProduct,
                )
              : const Text("Products"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: context.read<ProductViewModel>().onShowSearchBar,
            ),
          ]),
      body: Container(
        padding: EdgeInsets.all(AppDemensions.appSize20),
        child: ListView.separated(
          itemCount: context.watch<ProductViewModel>().state.showSearch
              ? context.watch<ProductViewModel>().state.searchList.length
              : context.watch<ProductViewModel>().state.productList.length,
          itemBuilder: ((context, index) {
            final productList = context
                    .watch<ProductViewModel>()
                    .state
                    .showSearch
                ? context.watch<ProductViewModel>().state.searchList[index]
                : context.watch<ProductViewModel>().state.productList[index];
            return InkWell(
              onTap: () {},
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
                              productList?.condition.name ?? "",
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/iphone_14_pro_max.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      productList.toString(),
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
                          'SELL',
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
        onPressed: context.read<ProductViewModel>().onAddProductButtonPress,
        child: Icon(
          Icons.add,
          size: AppDemensions.appSize25,
        ),
      ),
    );
  }
}

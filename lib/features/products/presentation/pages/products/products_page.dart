import 'package:flutter/material.dart';
import 'package:pear_market/features/products/presentation/widgets/bottom_sheet_filter.dart';
import 'package:provider/provider.dart';

import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/products/domain/entities/filter_entity.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/product_card.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productList = context.watch<ProductViewModel>().state.productList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.watch<ProductViewModel>().productType.name.toUpperCase(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                final filter = await showModalBottomSheet(
                  isDismissible: true,
                  context: context,
                  builder: (_) {
                    return ChangeNotifierProvider.value(
                      value: Provider.of<ProductViewModel>(context),
                      child: BottomSheetFilter(
                        savedFilter:
                            context.watch<ProductViewModel>().state.filter,
                      ),
                    );
                  },
                );
                context
                    .read<ProductViewModel>()
                    .onFilterButtonPress(filter as FilterEntity?);
              },
              icon: const Icon(Icons.filter_alt_outlined))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(AppDemensions.appSize20),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: productList.length,
          itemBuilder: ((context, index) {
            return ProductCard(
              product: productList[index],
              onTapCard: () =>
                  context.read<ProductViewModel>().onDetailProductButton(index),
              onTapSell: () =>
                  context.read<ProductViewModel>().onSellButtonPress(index),
            );
          }),
          separatorBuilder: (_, index) => SizedBox(
            height: AppDemensions.appSize20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<ProductViewModel>().onAddProductButtonPress,
        child: Icon(
          Icons.add,
          size: AppDemensions.appSize25,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}

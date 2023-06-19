import 'package:flutter/material.dart';
import 'package:pear_market/presentation/pages/add_product/provider/add_product_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/demencions.dart';
import '../../../core/util/enums.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add iPhone"),
        actions: [
          FilledButton(
              onPressed: context.read<AddProductViewModel>().saveProduct,
              child: Text(
                "SAVE",
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<int>(
                  value: context
                      .watch<AddProductViewModel>()
                      .state
                      .product
                      .condition
                      .index,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: ProductCondition.values
                      .map((e) => DropdownMenuItem(
                            value: e.index,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddProductViewModel>().addProductCondition,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  value: context
                      .watch<AddProductViewModel>()
                      .state
                      .product
                      .generation,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddProductViewModel>()
                      .state
                      .generationList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddProductViewModel>().addProductGeneration,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  hint: const Text("Choose color"),
                  value: context
                          .watch<AddProductViewModel>()
                          .state
                          .colorList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddProductViewModel>()
                          .state
                          .colorList
                          .first,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddProductViewModel>()
                      .state
                      .colorList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddProductViewModel>().addProductColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

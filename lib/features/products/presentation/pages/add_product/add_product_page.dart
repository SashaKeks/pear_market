import 'package:flutter/material.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/provider/add_product_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/demencions.dart';
import '../../../../../core/util/enums.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add iPhone"),
        actions: [
          FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AddProductViewModel>().saveProduct();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Fields are wrong'),
                    )),
                  );
                }
              },
              child: const Text(
                "SAVE",
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: _formKey,
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
                  icon: const Icon(
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
                          .generationList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddProductViewModel>()
                          .state
                          .generationList
                          .last,
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
                          .last,
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
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  value: context
                          .watch<AddProductViewModel>()
                          .state
                          .storageList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddProductViewModel>()
                          .state
                          .storageList
                          .last,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddProductViewModel>()
                      .state
                      .storageList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddProductViewModel>().addProductStorage,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  validator: (value) {
                    if (double.tryParse(value ?? '') == null) {
                      return "Only integer value";
                    }
                    return null;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Buy Price",
                  ),
                  onChanged:
                      context.read<AddProductViewModel>().addProductBuyPrice,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<int>(
                  value: context
                      .watch<AddProductViewModel>()
                      .state
                      .product
                      .buyCurrency
                      .index,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: ProductCurrency.values
                      .map((e) => DropdownMenuItem(
                            value: e.index,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddProductViewModel>().addProductBuyCurrency,
                ),
                SizedBox(height: AppDemensions.appSize20),
                context.watch<AddProductViewModel>().state.showExRateField
                    ? TextFormField(
                        validator: (value) {
                          if (double.tryParse(value ?? '') == null) {
                            return "Only integer value";
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: "Price ex-rate",
                        ),
                        onChanged: context
                            .read<AddProductViewModel>()
                            .addProductBuyExRate,
                      )
                    : const SizedBox(),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  minLines: 3,
                  maxLines: null,
                  onChanged:
                      context.read<AddProductViewModel>().addProductDescription,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

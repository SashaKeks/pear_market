import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/add_product/iphone/provider/add_iphone_view_model.dart';
import 'package:provider/provider.dart';

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
                  context.read<AddIphoneViewModel>().saveProduct();
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
                      .watch<AddIphoneViewModel>()
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
                      context.read<AddIphoneViewModel>().addProductCondition,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  value: context
                          .watch<AddIphoneViewModel>()
                          .state
                          .generationList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddIphoneViewModel>()
                          .state
                          .generationList
                          .last,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddIphoneViewModel>()
                      .state
                      .generationList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddIphoneViewModel>().addProductGeneration,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  value: context
                          .watch<AddIphoneViewModel>()
                          .state
                          .colorList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddIphoneViewModel>()
                          .state
                          .colorList
                          .last,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddIphoneViewModel>()
                      .state
                      .colorList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: context.read<AddIphoneViewModel>().addProductColor,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<String>(
                  value: context
                          .watch<AddIphoneViewModel>()
                          .state
                          .storageList
                          .isEmpty
                      ? null
                      : context
                          .watch<AddIphoneViewModel>()
                          .state
                          .storageList
                          .last,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: context
                      .watch<AddIphoneViewModel>()
                      .state
                      .storageList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged:
                      context.read<AddIphoneViewModel>().addProductStorage,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                              .watch<AddIphoneViewModel>()
                              .state
                              .product
                              .buyPrice ==
                          0
                      ? null
                      : context
                          .watch<AddIphoneViewModel>()
                          .state
                          .product
                          .buyPrice
                          .toString(),
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
                      context.read<AddIphoneViewModel>().addProductBuyPrice,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DropdownButtonFormField<int>(
                  value: context
                      .watch<AddIphoneViewModel>()
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
                      context.read<AddIphoneViewModel>().addProductBuyCurrency,
                ),
                SizedBox(height: AppDemensions.appSize20),
                context.watch<AddIphoneViewModel>().state.showExRateField
                    ? TextFormField(
                        initialValue: context
                                    .watch<AddIphoneViewModel>()
                                    .state
                                    .product
                                    .buyExRate ==
                                1
                            ? null
                            : context
                                .watch<AddIphoneViewModel>()
                                .state
                                .product
                                .buyPrice
                                .toString(),
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
                            .read<AddIphoneViewModel>()
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
                      context.read<AddIphoneViewModel>().addProductDescription,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

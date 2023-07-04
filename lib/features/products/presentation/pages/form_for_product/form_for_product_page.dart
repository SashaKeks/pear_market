import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/provider/form_for_product_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/date_time_picker.dart';
import 'package:pear_market/features/products/presentation/widgets/drop_down_button_for_form.dart';
import 'package:provider/provider.dart';

class FormForProductPage extends StatelessWidget {
  const FormForProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: [
          FilledButton(
              onPressed: context.read<FormForProductViewModel>().saveProduct,
              child: const Text("SAVE"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: context.read<FormForProductViewModel>().formKey,
            child: Column(
              children: [
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCondition>(
                  value: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .condition,
                  items: ProductCondition.values,
                  onChanged: (value) => context
                      .read<FormForProductViewModel>()
                      .addProductCondition(value?.index),
                  enumList: true,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .generation,
                  items: context
                      .watch<FormForProductViewModel>()
                      .state
                      .generationList,
                  onChanged: context
                      .read<FormForProductViewModel>()
                      .addProductGeneration,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .color,
                  items:
                      context.watch<FormForProductViewModel>().state.colorList,
                  onChanged:
                      context.read<FormForProductViewModel>().addProductColor,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .storage,
                  items: context
                      .watch<FormForProductViewModel>()
                      .state
                      .storageList,
                  onChanged:
                      context.read<FormForProductViewModel>().addProductStorage,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                              .watch<FormForProductViewModel>()
                              .state
                              .product
                              .buyPrice ==
                          0
                      ? null
                      : context
                          .watch<FormForProductViewModel>()
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
                  onChanged: context
                      .read<FormForProductViewModel>()
                      .addProductBuyPrice,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCurrency>(
                  enumList: true,
                  value: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .buyCurrency,
                  items: ProductCurrency.values,
                  onChanged: (value) => context
                      .read<FormForProductViewModel>()
                      .addProductBuyCurrency(value?.index),
                ),
                SizedBox(height: AppDemensions.appSize20),
                context.watch<FormForProductViewModel>().state.showExRateField
                    ? TextFormField(
                        initialValue: context
                                    .watch<FormForProductViewModel>()
                                    .state
                                    .product
                                    .buyExRate ==
                                1
                            ? null
                            : context
                                .watch<FormForProductViewModel>()
                                .state
                                .product
                                .buyExRate
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
                            .read<FormForProductViewModel>()
                            .addProductBuyExRate,
                      )
                    : const SizedBox(),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                      .watch<FormForProductViewModel>()
                      .state
                      .product
                      .description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  minLines: 3,
                  maxLines: null,
                  onChanged: context
                      .read<FormForProductViewModel>()
                      .addProductDescription,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DateTimePicker(
                  context: context,
                  time: context
                      .read<FormForProductViewModel>()
                      .state
                      .product
                      .buyDateTime,
                  onDateTimeChanged:
                      context.read<FormForProductViewModel>().addBuyDateTime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

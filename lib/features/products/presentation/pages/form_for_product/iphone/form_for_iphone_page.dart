import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/form_for_product/iphone/provider/form_for_iphone_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/date_time_picker.dart';
import 'package:pear_market/features/products/presentation/widgets/drop_down_button_for_form.dart';
import 'package:provider/provider.dart';

class FormForIphonePage extends StatelessWidget {
  const FormForIphonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add iPhone"),
        actions: [
          FilledButton(
              onPressed: context.read<FormForIphoneViewModel>().saveProduct,
              child: const Text("SAVE"))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: context.read<FormForIphoneViewModel>().formKey,
            child: Column(
              children: [
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCondition>(
                  value: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .product
                      .condition,
                  items: ProductCondition.values,
                  onChanged: (value) => context
                      .read<FormForIphoneViewModel>()
                      .addProductCondition(value?.index),
                  enumList: true,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .product
                      .generation,
                  items: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .generationList,
                  onChanged: context
                      .read<FormForIphoneViewModel>()
                      .addProductGeneration,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .product
                      .color,
                  items:
                      context.watch<FormForIphoneViewModel>().state.colorList,
                  onChanged:
                      context.read<FormForIphoneViewModel>().addProductColor,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<String>(
                  value: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .product
                      .storage,
                  items:
                      context.watch<FormForIphoneViewModel>().state.storageList,
                  onChanged:
                      context.read<FormForIphoneViewModel>().addProductStorage,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                              .watch<FormForIphoneViewModel>()
                              .state
                              .product
                              .buyPrice ==
                          0
                      ? null
                      : context
                          .watch<FormForIphoneViewModel>()
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
                      context.read<FormForIphoneViewModel>().addProductBuyPrice,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCurrency>(
                  enumList: true,
                  value: context
                      .watch<FormForIphoneViewModel>()
                      .state
                      .product
                      .buyCurrency,
                  items: ProductCurrency.values,
                  onChanged: (value) => context
                      .read<FormForIphoneViewModel>()
                      .addProductBuyCurrency(value?.index),
                ),
                SizedBox(height: AppDemensions.appSize20),
                context.watch<FormForIphoneViewModel>().state.showExRateField
                    ? TextFormField(
                        initialValue: context
                                    .watch<FormForIphoneViewModel>()
                                    .state
                                    .product
                                    .buyExRate ==
                                1
                            ? null
                            : context
                                .watch<FormForIphoneViewModel>()
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
                            .read<FormForIphoneViewModel>()
                            .addProductBuyExRate,
                      )
                    : const SizedBox(),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                      .watch<FormForIphoneViewModel>()
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
                      .read<FormForIphoneViewModel>()
                      .addProductDescription,
                ),
                SizedBox(height: AppDemensions.appSize20),
                DateTimePicker(
                  context: context,
                  time: context
                      .read<FormForIphoneViewModel>()
                      .state
                      .product
                      .buyDateTime,
                  onDateTimeChanged:
                      context.read<FormForIphoneViewModel>().addBuyDateTime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/presentation/pages/sell_product/provider/sell_product_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/date_time_picker.dart';
import 'package:pear_market/features/products/presentation/widgets/drop_down_button_for_form.dart';
import 'package:provider/provider.dart';

class SellProductPage extends StatelessWidget {
  const SellProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sell Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: context.read<SellProductViewModel>().formKey,
            child: Column(
              children: [
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                      .watch<SellProductViewModel>()
                      .product
                      .sellPrice
                      ?.toString(),
                  validator: (value) {
                    if (double.tryParse(value ?? '') == null) {
                      return "Only integer value";
                    }
                    return null;
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Sell Price",
                  ),
                  onChanged:
                      context.read<SellProductViewModel>().addProductSellPrice,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCurrency>(
                  enumList: true,
                  value: context
                      .watch<SellProductViewModel>()
                      .product
                      .sellCurrency,
                  items: ProductCurrency.values,
                  onChanged: (value) => context
                      .read<SellProductViewModel>()
                      .addProductSellCurrency(value?.index),
                ),
                context.watch<SellProductViewModel>().showExRateField
                    ? Column(
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<SellProductViewModel>()
                                .product
                                .sellExRate
                                ?.toString(),
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
                                .read<SellProductViewModel>()
                                .addProductSellExRate,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      )
                    : const SizedBox(),
                DateTimePicker(
                  context: context,
                  time: context
                          .read<SellProductViewModel>()
                          .product
                          .sellDateTime ??
                      DateTime.now(),
                  onDateTimeChanged:
                      context.read<SellProductViewModel>().addSellDateTime,
                ),
                SizedBox(height: AppDemensions.appSize20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: context.read<SellProductViewModel>().onSellPress,
                    child: Text(
                      "Sell",
                      style: GoogleFonts.montserrat(
                        fontSize: AppDemensions.appSize20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

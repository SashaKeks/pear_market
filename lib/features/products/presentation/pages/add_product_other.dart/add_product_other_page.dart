import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums/product_condition_enum.dart';
import 'package:pear_market/core/util/enums/product_currency_enum.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/products/presentation/pages/add_product_other.dart/provider/add_product_other_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/date_time_picker.dart';
import 'package:pear_market/features/products/presentation/widgets/drop_down_button_for_form.dart';
import 'package:provider/provider.dart';

class AddProductOtherPage extends StatelessWidget {
  const AddProductOtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductTypeEnum productType =
        context.read<AddProductOtherViewModel>().productType ??
            context.read<AddProductOtherViewModel>().product.type;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD PRODUCT"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: context.read<AddProductOtherViewModel>().onSavePress,
            child: const Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: context.read<AddProductOtherViewModel>().formKey,
            child: Column(
              children: [
                dropDownButtonForForm<ProductConditionEnum>(
                  enumList: true,
                  value: context
                      .watch<AddProductOtherViewModel>()
                      .product
                      .condition,
                  items: ProductConditionEnum.values,
                  onChanged: context
                      .read<AddProductOtherViewModel>()
                      .onConditionChange,
                ),
                TextFormField(
                  initialValue: context
                      .watch<AddProductOtherViewModel>()
                      .product
                      .generation,
                  decoration: const InputDecoration(
                    labelText: "Product generation",
                  ),
                  onChanged: context
                      .read<AddProductOtherViewModel>()
                      .onGenerationChange,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue:
                      context.watch<AddProductOtherViewModel>().product.color,
                  decoration: const InputDecoration(
                    labelText: "Product color",
                  ),
                  onChanged:
                      context.read<AddProductOtherViewModel>().onColorChange,
                ),
                SizedBox(height: AppDemensions.appSize20),
                productType == ProductTypeEnum.accessories
                    ? const SizedBox()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<AddProductOtherViewModel>()
                                .product
                                .storage,
                            decoration: const InputDecoration(
                              labelText: "Product storage",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onStorageChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                productType == ProductTypeEnum.accessories
                    ? const SizedBox()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<AddProductOtherViewModel>()
                                .product
                                .proc,
                            decoration: const InputDecoration(
                              labelText: "Product processor",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onProcChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                productType == ProductTypeEnum.accessories
                    ? const SizedBox()
                    : Column(
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<AddProductOtherViewModel>()
                                .product
                                .ram,
                            decoration: const InputDecoration(
                              labelText: "Product RAM",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onRamChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                productType == ProductTypeEnum.accessories
                    ? const SizedBox()
                    : Column(
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<AddProductOtherViewModel>()
                                .product
                                .video,
                            decoration: const InputDecoration(
                              labelText: "Product Video-Card",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onVideoChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                productType == ProductTypeEnum.accessories
                    ? const SizedBox()
                    : Column(
                        children: [
                          TextFormField(
                            initialValue: context
                                .watch<AddProductOtherViewModel>()
                                .product
                                .video,
                            decoration: const InputDecoration(
                              labelText: "Product Video-Card",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onVideoChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                TextFormField(
                  initialValue: context
                              .watch<AddProductOtherViewModel>()
                              .product
                              .buyPrice ==
                          0
                      ? null
                      : context
                          .watch<AddProductOtherViewModel>()
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
                      context.read<AddProductOtherViewModel>().onBuyPriceChange,
                ),
                SizedBox(height: AppDemensions.appSize20),
                dropDownButtonForForm<ProductCurrencyEnum>(
                  enumList: true,
                  value: context
                      .watch<AddProductOtherViewModel>()
                      .product
                      .buyCurrency,
                  items: ProductCurrencyEnum.values,
                  onChanged: context
                      .read<AddProductOtherViewModel>()
                      .onBuyCurrencyChange,
                ),
                context.watch<AddProductOtherViewModel>().product.buyCurrency ==
                        ProductCurrencyEnum.UAH
                    ? const SizedBox()
                    : Column(
                        children: [
                          TextFormField(
                            initialValue: context
                                        .watch<AddProductOtherViewModel>()
                                        .product
                                        .buyExRate ==
                                    1
                                ? null
                                : context
                                    .watch<AddProductOtherViewModel>()
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
                              labelText: "Buy Ex-Rate",
                            ),
                            onChanged: context
                                .read<AddProductOtherViewModel>()
                                .onBuyExRateChange,
                          ),
                          SizedBox(height: AppDemensions.appSize20),
                        ],
                      ),
                DateTimePicker(
                  context: context,
                  time: context
                      .read<AddProductOtherViewModel>()
                      .product
                      .buyDateTime,
                  onDateTimeChanged: context
                      .read<AddProductOtherViewModel>()
                      .onBuyDateTimeChange,
                ),
                SizedBox(height: AppDemensions.appSize20),
                TextFormField(
                  initialValue: context
                      .watch<AddProductOtherViewModel>()
                      .product
                      .description,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                  minLines: 3,
                  maxLines: null,
                  onChanged: context
                      .read<AddProductOtherViewModel>()
                      .onDescriptionChange,
                ),
                SizedBox(height: AppDemensions.appSize20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

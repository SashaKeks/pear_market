import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/products/domain/entities/filter_entity.dart';
import 'package:pear_market/features/products/presentation/pages/products/provider/product_view_model.dart';
import 'package:pear_market/features/products/presentation/widgets/drop_down_filter.dart';
import 'package:provider/provider.dart';

class BottomSheetFilter extends StatefulWidget {
  FilterEntity? savedFilter;
  BottomSheetFilter({
    Key? key,
    this.savedFilter,
  }) : super(key: key);

  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  FilterEntity filterEntity = FilterEntity();
  @override
  void initState() {
    if (widget.savedFilter != null) {
      setState(() {
        filterEntity = widget.savedFilter!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDemensions.appSize10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Clear filter")),
              TextButton(
                  onPressed: () => Navigator.pop(context, filterEntity),
                  child: const Text("Filter"))
            ],
          ),
          DropDownFilter<ProductCondition>(
            enumList: true,
            hint: const Text("Condition filter"),
            value: filterEntity.condition,
            items: ProductCondition.values,
            onChanged: (newCondition) => setState(
              () {
                filterEntity =
                    filterEntity.copyWith(condition: () => newCondition);
              },
            ),
          ),
          DropDownFilter<ProductStatus>(
            enumList: true,
            hint: const Text("Status filter"),
            value: filterEntity.status,
            items: ProductStatus.values,
            onChanged: (newStatus) => setState(
              () {
                filterEntity = filterEntity.copyWith(status: () => newStatus);
              },
            ),
          ),
          DropDownFilter<String>(
              hint: const Text("Generation filter"),
              value: filterEntity.generation,
              items: context.watch<ProductViewModel>().state.generationList,
              onChanged: (newGeneration) {
                filterEntity = filterEntity.copyWith(color: () => null);
                context.read<ProductViewModel>().getProductColor(newGeneration);
                setState(
                  () {
                    filterEntity =
                        filterEntity.copyWith(generation: () => newGeneration);
                  },
                );
              }),
          DropDownFilter<String?>(
            hint: const Text("Color filter"),
            keyF: context.watch<ProductViewModel>().key,
            value: filterEntity.color,
            items: context.watch<ProductViewModel>().state.colorList,
            onChanged: (color) => setState(() {
              filterEntity = filterEntity.copyWith(color: () => color);
            }),
          ),
          DropDownFilter<String?>(
            hint: const Text("Storage filter"),
            value: filterEntity.storage,
            items: context.watch<ProductViewModel>().state.storagetList,
            onChanged: (storage) => setState(() {
              filterEntity = filterEntity.copyWith(storage: () => storage);
            }),
          ),
        ],
      ),
    );
  }
}

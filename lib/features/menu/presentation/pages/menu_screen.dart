import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/presentation/widgets/menu_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppDemensions.appSize10,
          ),
          Wrap(
            children: List.generate(
              ProductTypeEnum.values.length,
              (index) => MenuItem(index: index),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/menu/presentation/provider/sub_menu_view_model.dart';
import 'package:pear_market/features/menu/presentation/widgets/sub_menu_item.dart';
import 'package:provider/provider.dart';

class SubMenuScreen extends StatelessWidget {
  const SubMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stateRead = context.read<SubMenuViewModel>();
    final stateWatch = context.watch<SubMenuViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          stateRead.subMenuType.name.toUpperCase(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            AppDemensions.appSize10,
          ),
          child: Wrap(
            spacing: AppDemensions.appSize10,
            runSpacing: AppDemensions.appSize10,
            children: List.generate(
              stateWatch.generationList.length,
              (index) => SubMenuItem(
                generation: stateWatch.generationList[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

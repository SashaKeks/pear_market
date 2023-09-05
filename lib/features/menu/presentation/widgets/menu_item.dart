import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/presentation/provider/menu_view_model.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final int index;
  const MenuItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final stateRead = context.read<MenuViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDemensions.appSize10,
        vertical: AppDemensions.appSize5,
      ),
      child: InkWell(
        onTap: () => stateRead.onMenuItemTap(index),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(
              AppDemensions.appSize20,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppDemensions.appSize150,
                child: Image.asset(
                  stateRead.getImagePath(index),
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                ProductTypeEnum.values[index].name.toUpperCase(),
                style: GoogleFonts.nanumGothic(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppDemensions.appSize25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

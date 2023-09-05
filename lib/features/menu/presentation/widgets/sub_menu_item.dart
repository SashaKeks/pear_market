import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';
import 'package:pear_market/features/menu/presentation/provider/sub_menu_view_model.dart';
import 'package:provider/provider.dart';

class SubMenuItem extends StatelessWidget {
  final GenerationEntity generation;
  const SubMenuItem({super.key, required this.generation});

  @override
  Widget build(BuildContext context) {
    final stateRead = context.read<SubMenuViewModel>();

    return GestureDetector(
      onTap: () => stateRead.onSubMenuItemButtonPress(generation),
      child: Container(
        width: double.infinity,
        height: AppDemensions.appSize100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(
            AppDemensions.appSize20,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                generation.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.nanumGothic(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppDemensions.appSize25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';
import 'package:pear_market/features/menu/presentation/provider/sub_menu_view_model.dart';
import 'package:provider/provider.dart';

class SubMenuPage extends StatelessWidget {
  const SubMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<SubMenuViewModel>().subMenuType.name.toUpperCase(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDemensions.appSize10),
          child: Wrap(
            spacing: AppDemensions.appSize10,
            runSpacing: AppDemensions.appSize10,
            children: List.generate(
              context.watch<SubMenuViewModel>().generationList.length,
              (index) => SubMenuItem(
                  title:
                      context.watch<SubMenuViewModel>().generationList[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class SubMenuItem extends StatelessWidget {
  final Generation title;
  const SubMenuItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: AppDemensions.appSize100,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(AppDemensions.appSize20)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title.generation.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nanumGothic(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/admin/presentation/providers/admin_panel_view_model.dart';
import 'package:provider/provider.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDemensions.appSize10,
      ),
      child: InkWell(
        onTap: context.read<AdminPanelViewModel>().createUser,
        child: DottedBorder(
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: Radius.circular(AppDemensions.appSize20),
          color: Theme.of(context).textTheme.titleSmall?.color ??
              Colors.transparent,
          strokeWidth: 1,
          dashPattern: [AppDemensions.appSize10, AppDemensions.appSize10],
          child: SizedBox(
            width: double.infinity,
            height: AppDemensions.appSize100,
            child: Center(
                child: Text(
              "+ ADD USER",
              style: GoogleFonts.nanumGothic(
                  textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 27,
                color: Theme.of(context).textTheme.titleSmall?.color ??
                    Colors.transparent,
              )),
            )),
          ),
        ),
      ),
    );
  }
}

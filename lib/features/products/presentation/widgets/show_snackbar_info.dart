import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';

showSnackbarInfo(BuildContext context, [String? infoText]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Expanded(
          child: Text(
            textAlign: TextAlign.center,
            infoText ?? "Somthing was wrong",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: AppDemensions.appSize20,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: (Colors.black),
    ),
  );
}

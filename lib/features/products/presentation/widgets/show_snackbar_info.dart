import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';

showSnackbarInfo(BuildContext context, [String? infoText]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Row(
          children: [
            Expanded(
              flex: 5,
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
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () =>
                    ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: const Text("CLOSE"),
              ),
            )
          ],
        ),
      ),
      backgroundColor: (Colors.black),
    ),
  );
}

import 'package:flutter/material.dart';

showSnackbarError(BuildContext context, [String? infoText]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        infoText ?? "Somthing was wrong",
      ),
      action: SnackBarAction(
        textColor: Colors.white,
        label: 'Hide',
        onPressed: () {},
      ),
    ),
  );
}

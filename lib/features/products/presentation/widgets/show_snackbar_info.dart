import 'package:flutter/material.dart';

showSnackbarInfo(BuildContext context, [String? infoText]) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        infoText ?? "Somthing was wrong",
      ),
      action: SnackBarAction(
        textColor: Theme.of(context).primaryColorLight,
        label: 'Hide',
        onPressed: () {},
      ),
    ),
  );
}

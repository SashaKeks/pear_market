import 'package:flutter/material.dart';

Future<bool?> showAlertDialogDelete({
  required BuildContext context,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are You Sure ?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you realy want delete this product'),
              Text('Press "Ok" to delete and "Cancel" for exit'),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ],
      );
    },
  );
}

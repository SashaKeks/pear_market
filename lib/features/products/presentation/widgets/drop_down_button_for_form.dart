import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';

dropDownButtonForForm<T>(
    {T? value,
    required List<T> items,
    required void Function(T?)? onChanged,
    bool enumList = false,
    Widget? hint,
    Key? key}) {
  return DropdownButtonFormField<T>(
    value: value,
    key: key,
    hint: hint,
    borderRadius: BorderRadius.circular(AppDemensions.appSize20),
    icon: const Icon(
      Icons.keyboard_double_arrow_down_sharp,
    ),
    items: items
        .map((e) => DropdownMenuItem(
              value: e,
              child: enumList ? Text((e as Enum).name) : Text(e.toString()),
            ))
        .toList(),
    onChanged: onChanged,
  );
}

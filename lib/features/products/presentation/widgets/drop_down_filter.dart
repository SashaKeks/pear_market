import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';

class DropDownFilter<T> extends StatefulWidget {
  T? value;
  final List<T> items;
  void Function(T?) onChanged;
  bool enumList;
  final Widget? hint;
  final Key? keyF;

  DropDownFilter({
    this.value,
    required this.items,
    required this.onChanged,
    this.enumList = false,
    this.hint,
    this.keyF,
  });

  @override
  State<DropDownFilter<T>> createState() => _DropDownFilterState<T>();
}

class _DropDownFilterState<T> extends State<DropDownFilter<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: DropdownButtonFormField<T>(
                  value: widget.value,
                  key: widget.keyF,
                  hint: widget.hint,
                  borderRadius: BorderRadius.circular(AppDemensions.appSize20),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                  ),
                  items: widget.items
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: widget.enumList
                                ? Text((e as Enum).name.toUpperCase())
                                : Text(e.toString()),
                          ))
                      .toList(),
                  onChanged: widget.onChanged,
                ),
              ),
              widget.value != null
                  ? IconButton(
                      onPressed: () {
                        widget.onChanged(null);
                        setState(() {
                          widget.value = null;
                        });
                      },
                      icon: Icon(Icons.delete_forever))
                  : const SizedBox()
            ],
          ),
          SizedBox(
            height: AppDemensions.appSize20,
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}

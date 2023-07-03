import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pear_market/core/resources/demencions.dart';

class DateTimePicker extends StatefulWidget {
  final BuildContext context;
  final DateTime time;
  final void Function(DateTime) onDateTimeChanged;
  const DateTimePicker({
    super.key,
    required this.context,
    required this.time,
    required this.onDateTimeChanged,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime setTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          padding: EdgeInsets.all(AppDemensions.appSize10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMMd().format(widget.time),
                style: GoogleFonts.montserrat(),
              ),
              const Icon(
                Icons.keyboard_double_arrow_down_sharp,
              ),
            ],
          ),
        ),
        onTap: () async {
          showCupertinoModalPopup<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(AppDemensions.appSize10),
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => widget.onDateTimeChanged(setTime),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 216,
                  padding: const EdgeInsets.only(top: 6.0),
                  // The Bottom margin is provided to align the popup above the system
                  // navigation bar.
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  // Provide a background color for the popup.
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  // Use a SafeArea widget to avoid system overlaps.
                  child: SafeArea(
                      top: false,
                      child: CupertinoDatePicker(
                          initialDateTime: widget.time,
                          mode: CupertinoDatePickerMode.date,
                          // This is called when the user changes the time.
                          onDateTimeChanged: (time) {
                            setState(() {
                              setTime = time;
                            });
                          })),
                ),
              ],
            ),
          );
        });
  }
}

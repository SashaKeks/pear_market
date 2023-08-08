import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData iconData;
  final IconData? showPassIcon;
  final bool isPassword;
  final void Function(String)? onChanged;

  CustomTextFormField(
      {super.key,
      required this.iconData,
      required this.onChanged,
      this.showPassIcon,
      this.isPassword = false});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: !widget.isPassword
            ? Icon(widget.iconData)
            : IconButton(
                onPressed: () => setState(() {
                  obscureText = !obscureText;
                }),
                icon: obscureText
                    ? Icon(widget.showPassIcon)
                    : Icon(widget.iconData),
              ),
      ),
      onChanged: widget.onChanged,
    );
  }
}

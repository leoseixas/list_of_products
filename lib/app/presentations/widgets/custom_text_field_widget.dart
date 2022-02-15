import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;
  final String errorText;
  final Color fillColor;
  const CustomTextFieldWidget({
    Key key,
    this.hintText,
    this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.errorText = '',
    this.fillColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        fillColor: fillColor,
        filled: true,
      ),
      obscureText: obscureText,
    );
  }
}

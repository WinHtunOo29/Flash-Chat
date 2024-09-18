import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final Function(String) onChanged;
  final bool isPassword;

  const InputTextField({
    super.key,
    this.hintText,
    required this.onChanged,
    required this.isPassword
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ? true : false,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
    );
  }
}
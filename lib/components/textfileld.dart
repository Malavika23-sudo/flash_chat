import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function(String value)? onChnaged;
  String? hintText;

  CustomTextField({this.onChnaged, this.hintText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChnaged,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
      style: TextStyle(color: Colors.black),
    );
  }
}

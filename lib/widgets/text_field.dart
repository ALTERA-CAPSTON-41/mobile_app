import 'package:capston_project/common/const.dart';
import 'package:flutter/material.dart';

class TextfieldCustom extends StatelessWidget {
  const TextfieldCustom({
    Key? key,
    required this.lable,
    required this.controller,
    required this.icon,
    this.obscureText = false,
  }) : super(key: key);

  final String lable;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: lable,
        suffix: Icon(
          icon,
          color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: kBodyText.copyWith(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$lable Tidak boleh kosong';
        }
        return null;
      },
    );
  }
}

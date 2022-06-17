import 'package:capston_project/common/const.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.label,
    this.obscureText = false,
    this.maxLength = 1,
    this.minLength = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChange;
  final String label;
  final bool obscureText;
  final int maxLength;
  final int minLength;

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      minLines: widget.minLength,
      maxLines: widget.maxLength,
      decoration: InputDecoration(
        hintText: widget.label,
        label: Text(widget.label),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kGreen1,
            width: 2,
          ),
        ),
      ),
      onChanged: widget.onChange,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "${widget.label} tidak boleh kosong";
        } else {
          return null;
        }
      },
      obscureText: widget.obscureText,
      textInputAction: TextInputAction.search,
    );
  }
}

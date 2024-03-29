import 'package:capston_project/common/const.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.label,
    this.obscureText = false,
    this.maxLength = 1,
    this.minLength = 1,
    this.formatters,
    this.textInputType,
    this.isEnabled = true,
    this.isEmail = false,
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String) onChange;
  final String label;
  final bool obscureText;
  final int maxLength;
  final int minLength;
  final List<TextInputFormatter>? formatters;
  final TextInputType? textInputType;
  final bool isEnabled;
  final bool isEmail;

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
      inputFormatters: widget.formatters,
      keyboardType: widget.textInputType,
      enabled: widget.isEnabled,
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
        if (widget.isEmail) {
          if (value?.isEmpty ?? true) {
            return "${widget.label} tidak boleh kosong";
          }

          if (!EmailValidator.validate(value.toString())) {
            return "Masukkan Email yang Valid";
          }
        }

        if (widget.obscureText) {
          if (value?.isEmpty ?? true) {
            return "${widget.label} tidak boleh kosong";
          }

          if (value!.length < 8) {
            return "kata sandi harus memiliki setidaknya 8 karakter";
          }
        }

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormFieldWidget extends StatelessWidget {
  const NumberFormFieldWidget({
    Key? key,
    required this.text,
    required this.controller,
    this.suffixText,
    this.autofocus = false,
    this.prefixText,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final String? prefixText;
  final String? suffixText;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$text tidak boleh kosong';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
      autofocus: autofocus,
      textAlign: TextAlign.end,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
        prefixText: prefixText,
        suffixText: suffixText,
      ),
    );
  }
}

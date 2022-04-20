import 'package:flutter/material.dart';

class NumberFormFieldWidget extends StatelessWidget {
  const NumberFormFieldWidget({
    Key? key,
    required this.text,
    required this.controller,
    this.suffixText,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final String? suffixText;
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
      textAlign: TextAlign.end,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
        suffixText: suffixText,
      ),
    );
  }
}

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
    this.currency,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  final String? prefixText;
  final String? suffixText;
  final bool autofocus;
  final TextInputFormatter? currency;
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> _inputFormatter = [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    ];
    if (currency != null) {
      _inputFormatter.add(currency!);
    }
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$text tidak boleh kosong';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      inputFormatters: _inputFormatter,
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

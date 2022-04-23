import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.text,
    required this.controller,
    this.onChanged,
  }) : super(key: key);
  final String text;
  final TextEditingController controller;
  final OnChangeCallback? onChanged;
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
      autocorrect: false,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
      ),
    );
  }
}

import 'package:flutter/material.dart';

typedef OnChangeCallback = void Function(dynamic value);

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.text,
    this.value,
  }) : super(key: key);
  final String text;
  final List<String> items;
  final OnChangeCallback onChanged;
  final String? value;
  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    String? dropDownValue = widget.value;
    return DropdownButtonFormField<String>(
      icon: const Icon(Icons.arrow_downward),
      value: dropDownValue,
      // elevation: 16,
      isExpanded: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.grey[800]),
        hintText: "Pilih ${widget.text}",
        fillColor: Colors.blue[200],
      ),
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          dropDownValue = value;
        });
        widget.onChanged(value);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.text} belum dipilih';
        }
        return null;
      },
    );
  }
}

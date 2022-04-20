import 'package:flutter/material.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _noteController = TextEditingController();
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Note"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            autofocus: true,
            controller: _noteController,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            maxLines: 50,
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.all(10.0),
              border: InputBorder.none,
              hintText: 'Ketik disini',
            ),
          ),
        ),
      ),
    );
  }
}

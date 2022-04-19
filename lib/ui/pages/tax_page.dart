import 'package:flutter/material.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class TaxPage extends StatelessWidget {
  const TaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text("PPN"),
        ),
        body: const Center(
          child: Text("TaxPage"),
        ),
      ),
    );
  }
}

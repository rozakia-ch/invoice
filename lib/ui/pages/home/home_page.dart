import 'package:flutter/material.dart';
import 'package:invoice/ui/pages/home/form_home.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Beranda"),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: FormHome(),
        ),
      ),
    );
  }
}

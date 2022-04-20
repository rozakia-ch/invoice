import 'package:flutter/material.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _items = List<String>.generate(10, (i) => '$i mbps');
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Paket"),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/form-paket-page');
          },
        ),
        body: ListView.builder(
          // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _items[index],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(CurrencyFormat.convertToIdr(index * 100000, 0)),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/form-paket-page',
                    arguments: {},
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            );
          },
        ),
      ),
    );
  }
}

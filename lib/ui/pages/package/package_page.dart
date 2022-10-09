import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/cubits/package/package_cubit.dart';
import 'package:invoice/models/package/package_model.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';

class PackagePage extends StatelessWidget {
  const PackagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, '/form-package-page', arguments: {
              'newEntry': true,
            });
          },
        ),
        body: BlocBuilder<PackageCubit, PackageState>(
          builder: (context, state) {
            if (state is ListPackagesState) {
              if (state.packages.isEmpty) {
                return const Center(
                  child: Text("Tidak Ada data"),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: state.packages.length,
                  itemBuilder: (context, index) {
                    final PackageModel package = state.packages[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListTile(
                        title: Text(
                          '${package.package} Mbps',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          CurrencyFormat.convertToIdr(package.price, 0),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/form-package-page',
                              arguments: {
                                'newEntry': false,
                                'index': index,
                                'package': package,
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        onLongPress: () {
                          _showAlertDialog(
                            context,
                            index,
                            '${package.package} Mbps',
                          );
                        },
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _showAlertDialog(BuildContext context, int index, String package) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        BlocProvider.of<PackageCubit>(context).mapPackageDelete(index: index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Perhatian!"),
      content: Text("Apakah anda yakin ingin menghapus paket $package?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

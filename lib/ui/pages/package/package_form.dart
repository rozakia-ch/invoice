import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/cubits/package/package_cubit.dart';
import 'package:invoice/models/package/package_model.dart';
import 'package:invoice/ui/widgets/number_form_field_widget.dart';

class PackageForm extends StatefulWidget {
  const PackageForm({Key? key, this.args}) : super(key: key);
  final Map? args;
  @override
  State<PackageForm> createState() => _PackageFormState();
}

class _PackageFormState extends State<PackageForm> {
  final _formKey = GlobalKey<FormState>();
  final _paketController = TextEditingController();
  final _priceController = TextEditingController();
  bool elevatedBtnState = true;
  @override
  Widget build(BuildContext context) {
    final bool _newEntry = widget.args!['newEntry'];
    if (!_newEntry) {
      final PackageModel _package = widget.args!['package'];
      _paketController.text = _package.package;
      _priceController.text = _package.price.toString();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Form Paket"),
      ),
      body: BlocListener<PackageCubit, PackageState>(
        listener: (context, state) {
          // if (state is PackageLoading) {}
          if (state is ListPackagesState) {
            Navigator.pushReplacementNamed(context, '/package-page');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                NumberFormFieldWidget(
                  autofocus: true,
                  text: "Paket\t",
                  controller: _paketController,
                  suffixText: "Mbps",
                ),
                const SizedBox(height: 10.0),
                NumberFormFieldWidget(
                  text: "Harga",
                  controller: _priceController,
                  prefixText: "Rp.",
                  currency: CurrencyTextInputFormatter(
                    name: '',
                    locale: 'id',
                    decimalDigits: 0,
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: elevatedBtnState
                        ? () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              if (_newEntry) {
                                BlocProvider.of<PackageCubit>(context)
                                    .mapPackageAdd(
                                  package: _paketController.text,
                                  price: int.parse(
                                    _priceController.text.replaceAll(".", ""),
                                  ),
                                );
                              } else {
                                BlocProvider.of<PackageCubit>(context)
                                    .mapPackageEdit(
                                  newPackage: _paketController.text,
                                  newPrice: int.parse(
                                    _priceController.text.replaceAll(".", ""),
                                  ),
                                  index: widget.args!['index'],
                                );
                              }
                              setState(() {
                                elevatedBtnState = !elevatedBtnState;
                              });
                            }
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.save),
                        SizedBox(width: 5.0),
                        Text('Simpan'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

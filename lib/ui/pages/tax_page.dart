import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/cubits/tax/tax_cubit.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';
import 'package:invoice/ui/widgets/number_form_field_widget.dart';

class TaxPage extends StatelessWidget {
  const TaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _taxController = TextEditingController();
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("PPN"),
        ),
        body: BlocBuilder<TaxCubit, TaxState>(
          builder: (context, state) {
            if (state is ListTaxState) {
              String _tax = state.taxes.isNotEmpty
                  ? state.taxes.first.tax.toString()
                  : '';
              _taxController.text = _tax;
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      NumberFormFieldWidget(
                        text: "PPN\t",
                        controller: _taxController,
                        suffixText: "%",
                        // autofocus: true,
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
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              if (state.taxes.isEmpty) {
                                BlocProvider.of<TaxCubit>(context).mapTaxAdd(
                                  tax: double.parse(_taxController.text),
                                );
                              } else {
                                BlocProvider.of<TaxCubit>(context).mapTaxEdit(
                                  index: 0,
                                  newTax: double.parse(_taxController.text),
                                );
                              }
                            }
                          },
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
              );
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
}

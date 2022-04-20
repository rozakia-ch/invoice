import 'package:flutter/material.dart';
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                NumberFormFieldWidget(
                  text: "PPN\t",
                  controller: _taxController,
                  suffixText: "%",
                  autofocus: true,
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
                        // If the form is valid, display a snackBar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
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
        ),
      ),
    );
  }
}

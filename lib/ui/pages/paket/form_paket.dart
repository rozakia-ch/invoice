import 'package:flutter/material.dart';
import 'package:invoice/ui/widgets/number_form_field_widget.dart';

class FormPaket extends StatelessWidget {
  const FormPaket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _paketController = TextEditingController();
    final _priceController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Form Paket"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              NumberFormFieldWidget(
                autofocus: true,
                text: "Paket\t",
                controller: _paketController,
                suffixText: "mbps",
              ),
              const SizedBox(height: 10.0),
              NumberFormFieldWidget(
                text: "Harga",
                controller: _priceController,
                prefixText: "Rp.",
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
                      // If the form is valid, display a snackbar. In the real world,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/ui/widgets/app_drawer.dart';
import 'package:invoice/ui/widgets/app_will_pop_scope.dart';
import 'package:invoice/ui/widgets/dropdown_widget.dart';
import 'package:invoice/ui/widgets/text_form_field_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _addressController = TextEditingController();
    final int _currentYear = DateTime.now().year.toInt();
    final int _currentMonth = DateTime.now().month.toInt();
    String _paketValue = '';
    String _monthValue = nameMonth[_currentMonth - 1];
    String _yearValue = _currentYear.toString();
    return AppWillPopScope(
      child: Scaffold(
        endDrawer: const AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          title: const Text("Beranda"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    text: "Nama",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 10.0),
                  TextFormFieldWidget(
                    text: "Alamat",
                    controller: _addressController,
                  ),
                  const SizedBox(height: 10.0),
                  DropdownWidget(
                      text: "Paket",
                      items: const ['1 mbps', '2 mbps', '3 mbps', '4 mbps'],
                      onChanged: (value) => _paketValue = value),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownWidget(
                          text: "Bulan",
                          value: _monthValue,
                          items: nameMonth,
                          onChanged: (value) => _monthValue = value,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: DropdownWidget(
                          text: "Tahun",
                          value: _yearValue,
                          items: List<String>.generate(
                              3, (i) => (_currentYear - i).toString()),
                          onChanged: (value) => _yearValue = value,
                        ),
                      ),
                    ],
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
                          printReceipt(
                            context,
                            name: _nameController.text,
                            address: _addressController.text,
                            paket: _paketValue,
                            month: _monthValue,
                            year: _yearValue,
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.print),
                          SizedBox(width: 5.0),
                          Text('Print'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void printReceipt(
    context, {
    required String name,
    required String address,
    required String paket,
    required String month,
    required String year,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$name, $address, $paket, $month, $year ")),
    );
  }
}

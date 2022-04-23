import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/hive/tax_hive.dart';
import 'package:invoice/ui/widgets/dropdown_widget.dart';

final TaxHive _taxHive = TaxHive();

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key, this.args}) : super(key: key);
  final Map? args;

  Future<double> _getTax() async {
    double tax = 0.0;
    await _taxHive.getFullTaxs().then((value) => tax = value.first.tax);
    return tax;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final int _price = int.parse(_getPackage(args!['package'])[1]);
    final String _package = _getPackage(args!['package'])[0];
    const TextStyle _titleStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );
    const TextStyle _valueStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    );
    const TextStyle _totalStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Periksa"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                args!['company'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Nama:', style: _titleStyle),
                  Text(args!['name'], style: _valueStyle),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Alamat:', style: _titleStyle),
                  Text(args!['address'], style: _valueStyle),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('BroadBand:', style: _titleStyle),
                  Text(_package, style: _valueStyle),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Harga:', style: _titleStyle),
                  Text(
                    CurrencyFormat.convertToIdr(_price, 0),
                    style: _valueStyle,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              FutureBuilder<double>(
                future: _getTax(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double _tax = snapshot.data!;
                    double _priceTax = _tax / 100 * _price;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PPN ($_tax%):', style: _titleStyle),
                        Text(
                          CurrencyFormat.convertToIdr(_priceTax, 0),
                          style: _valueStyle,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hutang:', style: _titleStyle),
                  Text(
                    CurrencyFormat.convertToIdr(int.parse(args!['debt']), 0),
                    style: _valueStyle,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              FutureBuilder<double>(
                future: _getTax(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double _tax = snapshot.data!;
                    double _priceTax = _tax / 100 * _price;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: _totalStyle),
                        Text(
                          CurrencyFormat.convertToIdr(
                              int.parse(args!['debt']) + _price + _priceTax, 0),
                          style: _totalStyle,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 10.0),
              DropdownWidget(
                items: [],
                onChanged: (value) {},
                text: "Printer",
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 12.5,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Print'),
                      SizedBox(width: 5.0),
                      Icon(Icons.print),
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

  List<String> _getPackage(package) {
    List<String> value = package.split('-');
    String price = value[1];
    String price1 = price.replaceAll('.', '');
    return [value[0], price1];
  }

  void printReceipt(
    context, {
    required String name,
    required String address,
    String? package,
    required String month,
    required String year,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$name, $address, $package, $month, $year")),
    );
  }
}

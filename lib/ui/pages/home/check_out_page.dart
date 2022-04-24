import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/hive/note_hive.dart';
import 'package:invoice/hive/tax_hive.dart';
import 'package:invoice/ui/pages/home/check_out_item.dart';
import 'package:invoice/ui/pages/home/check_out_total.dart';
import 'package:invoice/ui/widgets/elevated_button_widget.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key, this.args}) : super(key: key);
  final Map? args;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final TaxHive _taxHive = TaxHive();
  final NoteHive _noteHive = NoteHive();
  final _formKey = GlobalKey<FormState>();
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  double tax = 0.0;
  String note = '';

  @override
  void initState() {
    _getNote();
    _getDevicesItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int _price = int.parse(_getPackage(widget.args!['package'])[1]);
    final String _package = _getPackage(widget.args!['package'])[0];
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
                widget.args!['company'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5.0),
              CheckOutItem(title: 'Nama:', value: widget.args!['name']),
              const SizedBox(height: 5.0),
              CheckOutItem(title: 'Alamat:', value: widget.args!['address']),
              const SizedBox(height: 5.0),
              CheckOutItem(title: 'BroadBand:', value: _package),
              const SizedBox(height: 5.0),
              CheckOutItem(
                title: 'Harga:',
                value: CurrencyFormat.convertToIdr(_price, 0),
              ),
              const SizedBox(height: 5.0),
              FutureBuilder<double>(
                future: _getTax(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    double _tax = snapshot.data!;
                    double _priceTax = _tax / 100 * _price;
                    return Column(
                      children: [
                        CheckOutItem(
                          title: 'PPN ($_tax%):',
                          value: CurrencyFormat.convertToIdr(_priceTax, 0),
                        ),
                        const SizedBox(height: 5.0),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              CheckOutItem(
                title: 'Hutang:',
                value: CurrencyFormat.convertToIdr(
                    int.parse(widget.args!['debt']), 0),
              ),
              const SizedBox(height: 5.0),
              CheckOutTotal(
                  debt: int.parse(widget.args!['debt']), price: _price),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<BluetoothDevice>(
                items: _devices
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name!),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _device = value;
                    _connected = true;
                  });
                  bluetooth.isConnected.then((isConnected) {
                    bluetooth.connect(_device!);
                  });
                },
                value: _device,
                isExpanded: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Pilih Printer",
                  fillColor: Colors.blue[200],
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Printer belum dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              ElevationButtonWidget(
                text: 'Refresh Printer',
                icon: Icons.refresh,
                onPressed: () {
                  _getDevicesItems();
                },
              ),
              const SizedBox(height: 10.0),
              ElevationButtonWidget(
                text: 'Print',
                icon: Icons.print,
                onPressed: _connected
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text("Processing")),
                          // );
                          _printReceipt(
                            company: widget.args!['company'],
                            name: widget.args!['name'],
                            address: widget.args!['address'],
                            package: _package,
                            price: _price,
                            debt: int.parse(widget.args!['debt']),
                            month: widget.args!['month'],
                            year: widget.args!['year'],
                          );
                        }
                      }
                    // ignore: avoid_returning_null_for_void
                    : () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<double> _getTax() async {
    await _taxHive.getFullTaxs().then((value) => tax = value.first.tax);
    return tax;
  }

  Future<String> _getNote() async {
    await _noteHive.getFullNotes().then((value) => note = value.first.note);
    return note;
  }

  List<String> _getPackage(package) {
    List<String> value = package.split('-');
    String price = value[1];
    String price1 = price.replaceAll('.', '');
    return [value[0], price1];
  }

  // BLueThermal
  _getDevicesItems() async {
    _devices = await bluetooth.getBondedDevices();
    setState(() {});
  }

  void _printReceipt({
    required String company,
    required String name,
    required String address,
    required String package,
    required int price,
    required int debt,
    required String month,
    required String year,
  }) {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected != null) {
        bluetooth.printNewLine();
        bluetooth.printCustom(company, 3, 1);
        bluetooth.printLeftRight(
          DateFormat(dateFormat).format(DateTime.now()),
          DateFormat(timeFormat).format(DateTime.now()),
          1,
        );
        bluetooth.printNewLine();
        bluetooth.printLeftRight('Nama', name, 1);
        bluetooth.printCustom('Alamat: $address', 1, 0);
        bluetooth.printLeftRight('Broadband', package.trim(), 1);
        bluetooth.printLeftRight('Jatuh Tempo', '$month $year', 1);
        bluetooth.printLeftRight(
          'Harga',
          CurrencyFormat.convertToIdr(price, 0),
          1,
        );
        bluetooth.printLeftRight(
          'PPN ($tax%)',
          CurrencyFormat.convertToIdr(tax / 100 * price, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Hutang',
          CurrencyFormat.convertToIdr(debt, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Total',
          CurrencyFormat.convertToIdr(
              tax > 0 ? tax / 100 * price + price + debt : price + price + debt,
              0),
          1,
        );
        bluetooth.printNewLine();
        bluetooth.printCustom(note, 1, 0);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}

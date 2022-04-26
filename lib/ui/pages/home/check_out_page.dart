import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/cubits/printer/printer_cubit.dart';
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
  double tax = 0.0;
  String note = '';

  @override
  void initState() {
    _getNote();
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
                value: widget.args!['debt'],
              ),
              const SizedBox(height: 5.0),
              CheckOutTotal(
                  debt: int.parse(widget.args!['debt'].replaceAll('.', '')),
                  price: _price),
              const SizedBox(height: 10.0),
              BlocBuilder<PrinterCubit, PrinterState>(
                builder: (context, state) {
                  if (state is MyPrinterState) {
                    return DropdownButtonFormField<BluetoothDevice>(
                      items: state.devices
                          .map((e) => DropdownMenuItem(
                                child: Text(e.name!),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        BlocProvider.of<PrinterCubit>(context).connect(value);
                      },
                      value: state.device,
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(height: 10.0),
              ElevationButtonWidget(
                text: 'Refresh Printer',
                icon: Icons.refresh,
                onPressed: () {
                  BlocProvider.of<PrinterCubit>(context).mapInitial();
                },
              ),
              const SizedBox(height: 10.0),
              ElevationButtonWidget(
                text: 'Print',
                icon: Icons.print,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text("Processing")),
                    // );
                    BlocProvider.of<PrinterCubit>(context).printReceipt(
                      company: widget.args!['company'],
                      name: widget.args!['name'],
                      address: widget.args!['address'],
                      package: _package,
                      price: _price,
                      debt: int.parse(widget.args!['debt'].replaceAll('.', '')),
                      month: widget.args!['month'],
                      year: widget.args!['year'],
                      tax: tax,
                      note: note,
                    );
                    Navigator.pushReplacementNamed(context, '/home-page');
                  }
                },
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
}

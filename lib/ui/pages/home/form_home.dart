import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/cubits/package/package_cubit.dart';
import 'package:invoice/ui/pages/home/company_widget.dart';
import 'package:invoice/ui/widgets/dropdown_widget.dart';
import 'package:invoice/ui/widgets/number_form_field_widget.dart';
import 'package:invoice/ui/widgets/text_form_field_widget.dart';

class FormHome extends StatefulWidget {
  const FormHome({Key? key}) : super(key: key);

  @override
  State<FormHome> createState() => _FormHomeState();
}

class _FormHomeState extends State<FormHome> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _companyController = TextEditingController();
    final _nameController = TextEditingController();
    final _addressController = TextEditingController();
    final _debtController = TextEditingController();
    String? _packageValue;
    // Month Year
    final int _currentYear = DateTime.now().year.toInt();
    final int _currentMonth = DateTime.now().month.toInt();
    String _monthValue = nameMonth[_currentMonth - 1];
    String _yearValue = _currentYear.toString();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CompanyWidget(controller: _companyController),
          const SizedBox(height: 10.0),
          TextFormFieldWidget(
            text: "Nama Klien",
            controller: _nameController,
          ),
          const SizedBox(height: 10.0),
          TextFormFieldWidget(
            text: "Alamat",
            controller: _addressController,
            maxLines: 3,
          ),
          const SizedBox(height: 10.0),
          BlocBuilder<PackageCubit, PackageState>(
            builder: (context, state) {
              if (state is ListPackagesState) {
                return DropdownWidget(
                  text: "Paket",
                  items: state.packages.isNotEmpty
                      ? List<String>.generate(
                          state.packages.length,
                          (index) =>
                              '${state.packages[index].package} Mbps - ${CurrencyFormat.convertToIdr(state.packages[index].price, 0)}',
                        )
                      : [],
                  onChanged: (value) => _packageValue = value,
                );
              } else {
                return Container();
              }
            },
          ),
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
          NumberFormFieldWidget(
            text: "Kurangan Bulan Lalu",
            controller: _debtController,
            prefixText: 'Rp.',
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
                  vertical: 12.5,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, '/checkout-page', arguments: {
                    'company': _companyController.text,
                    'name': _nameController.text,
                    'address': _addressController.text,
                    'package': _packageValue,
                    'year': _yearValue,
                    'month': _monthValue,
                    'debt': _debtController.text,
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Periksa'),
                  SizedBox(width: 5.0),
                  Icon(Icons.check),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

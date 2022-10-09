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
    final formKey = GlobalKey<FormState>();
    final companyController = TextEditingController();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final debtController = TextEditingController();
    final discountController = TextEditingController();
    final rentCostController = TextEditingController();
    String? packageValue;
    // Month Year
    final int currentYear = DateTime.now().year.toInt();
    final int currentMonth = DateTime.now().month.toInt();
    String monthValue = nameMonth[currentMonth - 1];
    String yearValue = currentYear.toString();
    return Form(
      key: formKey,
      child: Column(
        children: [
          CompanyWidget(controller: companyController),
          const SizedBox(height: 10.0),
          TextFormFieldWidget(
            text: "Nama Klien",
            controller: nameController,
          ),
          const SizedBox(height: 10.0),
          TextFormFieldWidget(
            text: "Alamat",
            controller: addressController,
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
                  onChanged: (value) => packageValue = value,
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
                  value: monthValue,
                  items: nameMonth,
                  onChanged: (value) => monthValue = value,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: DropdownWidget(
                  text: "Tahun",
                  value: yearValue,
                  items: List<String>.generate(
                      3, (i) => (currentYear - i).toString()),
                  onChanged: (value) => yearValue = value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          NumberFormFieldWidget(
            text: "Kurangan Bulan Lalu",
            controller: debtController..text = "0",
            prefixText: 'Rp.',
            currency: CurrencyTextInputFormatter(
              name: '',
              locale: 'id',
              decimalDigits: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          NumberFormFieldWidget(
            text: "Biaya Sewa",
            controller: rentCostController..text = "0",
            prefixText: 'Rp.',
            currency: CurrencyTextInputFormatter(
              name: '',
              locale: 'id',
              decimalDigits: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          NumberFormFieldWidget(
            text: "Diskon",
            controller: discountController..text = "0",
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
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, '/checkout-page', arguments: {
                    'company': companyController.text,
                    'name': nameController.text,
                    'address': addressController.text,
                    'package': packageValue,
                    'year': yearValue,
                    'month': monthValue,
                    'debt': debtController.text,
                    'discount': discountController.text,
                    'rentCost': rentCostController.text
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

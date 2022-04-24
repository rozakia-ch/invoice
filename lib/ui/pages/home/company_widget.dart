import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/cubits/company/company_cubit.dart';
import 'package:invoice/hive/company_hive.dart';
import 'package:invoice/ui/widgets/text_form_field_widget.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    String _company = '';
    final CompanyHive _companyHive = CompanyHive();
    _getCompany() async {
      await _companyHive
          .getFullCompanys()
          .then((value) => _company = value.first.companyName);
      return _company;
    }

    return FutureBuilder(
      future: _getCompany(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          controller.text = snapshot.data.toString();
          return TextFormFieldWidget(
            text: "Nama Perusahaan",
            controller: controller,
            onChanged: (value) {
              BlocProvider.of<CompanyCubit>(context).mapCompanyEdit(
                index: 0,
                newCompany: value,
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:hive/hive.dart';
import 'dart:async';
import 'package:invoice/models/company/company_model.dart';

class CompanyHive {
  final String _boxName = "Company";
  // open a box
  Future<Box> companyBox() async {
    var box = await Hive.openBox<CompanyModel>(_boxName);
    return box;
  }

  // get full companies
  Future<List<CompanyModel>> getFullCompanys() async {
    final box = await companyBox();
    List<CompanyModel> companies = box.values.cast<CompanyModel>().toList();
    return companies;
  }

  // to add data in box
  Future<void> addToBox(CompanyModel company) async {
    final box = await companyBox();
    await box.add(company);
  }

  // update data
  Future<void> updateCompany(int index, CompanyModel company) async {
    final box = await companyBox();
    await box.putAt(index, company);
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice/hive/company_hive.dart';
import 'package:invoice/models/company/company_model.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final CompanyHive _companyHive = CompanyHive();
  List<CompanyModel> _companies = [];
  CompanyCubit() : super(CompanyInitial());
  // Stream Functions
  void mapInitial() async {
    emit(CompanyLoading());
    await _getCompanys();
    emit(ListCompanyState(companies: _companies));
  }

  void mapCompanyAdd({required String company}) async {
    emit(CompanyLoading());
    await addCompany(company: company);
    emit(ListCompanyState(companies: _companies));
  }

  void mapCompanyEdit({
    required int index,
    required String newCompany,
  }) async {
    emit(CompanyLoading());
    await updateCompany(index: index, newCompany: newCompany);
    emit(ListCompanyState(companies: _companies));
  }

  // Helper Functions
  Future<void> _getCompanys() async {
    await _companyHive.getFullCompanys().then((value) => _companies = value);
  }

  Future<void> addCompany({required String company}) async {
    await _companyHive.addToBox(CompanyModel(companyName: company));
    await _getCompanys();
  }

  Future<void> updateCompany({
    required int index,
    required String newCompany,
  }) async {
    await _companyHive.updateCompany(
        index, CompanyModel(companyName: newCompany));
    await _getCompanys();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice/hive/tax_hive.dart';
import 'package:invoice/models/tax/tax_model.dart';

part 'tax_state.dart';

class TaxCubit extends Cubit<TaxState> {
  final TaxHive _taxHive = TaxHive();
  List<TaxModel> _taxes = [];
  TaxCubit() : super(TaxInitial());

  // Stream Functions
  void mapInitial() async {
    emit(TaxLoading());
    await _getTaxs();
    emit(ListTaxState(taxes: _taxes));
  }

  void mapTaxAdd({required double tax}) async {
    emit(TaxLoading());
    await addTax(tax: tax);
    emit(ListTaxState(taxes: _taxes));
  }

  void mapTaxEdit({
    required int index,
    required double newTax,
  }) async {
    emit(TaxLoading());
    await updateTax(index: index, newTax: newTax);
    emit(ListTaxState(taxes: _taxes));
  }

  // Helper Functions
  Future<void> _getTaxs() async {
    await _taxHive.getFullTaxs().then((value) => _taxes = value);
  }

  Future<void> addTax({required double tax}) async {
    await _taxHive.addToBox(TaxModel(tax: tax));
    await _getTaxs();
  }

  Future<void> updateTax({
    required int index,
    required double newTax,
  }) async {
    await _taxHive.updateTax(index, TaxModel(tax: newTax));
    await _getTaxs();
  }
}

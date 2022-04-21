import 'package:hive/hive.dart';
import 'dart:async';
import 'package:invoice/models/tax/tax_model.dart';

class TaxHive {
  final String _boxName = "Tax";
  // open a box
  Future<Box> taxBox() async {
    var box = await Hive.openBox<TaxModel>(_boxName);
    return box;
  }

  // get full taxs
  Future<List<TaxModel>> getFullTaxs() async {
    final box = await taxBox();
    List<TaxModel> taxs = box.values.cast<TaxModel>().toList();
    return taxs;
  }

  // to add data in box
  Future<void> addToBox(TaxModel tax) async {
    final box = await taxBox();
    await box.add(tax);
  }

  // update data
  Future<void> updateTax(int index, TaxModel tax) async {
    final box = await taxBox();
    await box.putAt(index, tax);
  }
}

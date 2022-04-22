import 'package:hive/hive.dart';
import 'package:invoice/models/package/package_model.dart';
import 'dart:async';

class PackagesHive {
  final String _boxName = "Packages";
  // open a box
  Future<Box> packageBox() async {
    var box = await Hive.openBox<PackageModel>(_boxName);
    return box;
  }

  // get full package
  Future<List<PackageModel>> getFullPackages() async {
    final box = await packageBox();
    List<PackageModel> packages = box.values.cast<PackageModel>().toList();
    return packages;
  }

  // to add data in box
  Future<void> addToBox(PackageModel package) async {
    final box = await packageBox();
    await box.add(package);
  }

  // update data
  Future<void> updatePackage(int index, PackageModel package) async {
    final box = await packageBox();
    await box.putAt(index, package);
  }

  // delete data from box
  Future<void> deleteFromBox(int index) async {
    final box = await packageBox();
    await box.deleteAt(index);
  }

  // delete all data from box
  Future<void> deleteAll() async {
    final box = await packageBox();
    await box.clear();
  }
}

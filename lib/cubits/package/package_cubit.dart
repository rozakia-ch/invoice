import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invoice/hive/package_hive.dart';
import 'package:invoice/models/package/package_model.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackagesHive _packageHive = PackagesHive();
  List<PackageModel> _packages = [];
  PackageCubit() : super(PackageInitial());
  // Stream Functions
  void mapInitial() async {
    emit(PackageLoading());
    await _getPackages();
    emit(ListPackagesState(packages: _packages));
  }

  void mapPackageAdd({
    required String package,
    required int price,
  }) async {
    emit(PackageLoading());
    await _addToPackages(package: package, price: price);
    emit(ListPackagesState(packages: _packages));
  }

  void mapPackageEdit({
    required int index,
    required String newPackage,
    required int newPrice,
  }) async {
    emit(PackageLoading());
    await _updatePackage(
      index: index,
      newPackage: newPackage,
      newPrice: newPrice,
    );
    emit(ListPackagesState(packages: _packages));
  }

  void mapPackageDelete({required int index}) async {
    emit(PackageLoading());
    await _removeFromPackages(index: index);
    _packages.sort((a, b) {
      var aDate = a.package;
      var bDate = b.package;
      return aDate.compareTo(bDate);
    });
    emit(ListPackagesState(packages: _packages));
  }

  void mapPackagesDeleteAll() async {
    emit(PackageLoading());
    await _removeAll();
    emit(ListPackagesState(packages: _packages));
  }

  // Helper Functions
  Future<void> _getPackages() async {
    await _packageHive.getFullPackages().then((value) {
      // value.sort((a, b) => a.packageName.compareTo(b.packageName));
      _packages = value;
    });
  }

  Future<void> _addToPackages({
    required String package,
    required int price,
  }) async {
    await _packageHive.addToBox(PackageModel(package: package, price: price));
    await _getPackages();
  }

  Future<void> _updatePackage({
    required int index,
    required String newPackage,
    required int newPrice,
  }) async {
    await _packageHive.updatePackage(
      index,
      PackageModel(package: newPackage, price: newPrice),
    );
    await _getPackages();
  }

  Future<void> _removeFromPackages({required int index}) async {
    await _packageHive.deleteFromBox(index);
    await _getPackages();
  }

  Future<void> _removeAll() async {
    await _packageHive.deleteAll();
    await _getPackages();
  }
}

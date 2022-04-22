import 'package:hive/hive.dart';

part 'package_model.g.dart';

@HiveType(typeId: 2)
class PackageModel {
  @HiveField(0)
  final String package;
  @HiveField(1)
  final int price;
  PackageModel({required this.package, required this.price});
}

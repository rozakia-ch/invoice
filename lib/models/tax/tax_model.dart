import 'package:hive/hive.dart';

part 'tax_model.g.dart';

@HiveType(typeId: 4)
class TaxModel {
  @HiveField(0)
  final double tax;

  TaxModel({required this.tax});
}

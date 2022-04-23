import 'package:hive/hive.dart';

part 'company_model.g.dart';

@HiveType(typeId: 1)
class CompanyModel {
  @HiveField(0)
  final String companyName;
  CompanyModel({required this.companyName});
}

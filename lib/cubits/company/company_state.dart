part of 'company_cubit.dart';

abstract class CompanyState extends Equatable {
  const CompanyState();
}

class CompanyInitial extends CompanyState {
  @override
  List<Object> get props => [];
}

// loading
class CompanyLoading extends CompanyState {
  @override
  List<Object?> get props => [];
}

//  your companies
class ListCompanyState extends CompanyState {
  final List<CompanyModel> companies; // get all companies
  const ListCompanyState({required this.companies});
  @override
  List<Object?> get props => [];
}

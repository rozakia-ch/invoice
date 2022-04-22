part of 'tax_cubit.dart';

abstract class TaxState extends Equatable {
  const TaxState();
}

class TaxInitial extends TaxState {
  @override
  List<Object> get props => [];
}

// loading
class TaxLoading extends TaxState {
  @override
  List<Object?> get props => [];
}

//  your taxes
class ListTaxState extends TaxState {
  final List<TaxModel> taxes; // get all taxes
  const ListTaxState({required this.taxes});
  @override
  List<Object?> get props => [];
}

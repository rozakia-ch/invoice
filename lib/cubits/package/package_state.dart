part of 'package_cubit.dart';

abstract class PackageState extends Equatable {
  const PackageState();
}

class PackageInitial extends PackageState {
  @override
  List<Object> get props => [];
}

// loading
class PackageLoading extends PackageState {
  @override
  List<Object?> get props => [];
}

// List package
class ListPackagesState extends PackageState {
  final List<PackageModel> packages; // get all packages
  const ListPackagesState({required this.packages});
  @override
  List<Object?> get props => [];
}

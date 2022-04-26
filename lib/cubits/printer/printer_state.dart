part of 'printer_cubit.dart';

abstract class PrinterState extends Equatable {
  const PrinterState();
}

class PrinterInitial extends PrinterState {
  @override
  List<Object> get props => [];
}

class PrinterLoadingState extends PrinterState {
  @override
  List<Object?> get props => [];
}

class MyPrinterState extends PrinterState {
  final List<BluetoothDevice> devices;
  final BluetoothDevice? device;
  const MyPrinterState({required this.devices, this.device});
  @override
  List<Object?> get props => [devices, device];
}

class PrinterStateFailure extends PrinterState {
  @override
  List<Object?> get props => [];
}

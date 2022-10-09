import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:invoice/constants/constants.dart';

part 'printer_state.dart';

class PrinterCubit extends Cubit<PrinterState> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? connectedDevice;
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  PrinterCubit() : super(PrinterInitial());
  void mapInitial() async {
    emit(PrinterLoadingState());
    devices = await bluetooth.getBondedDevices();
    emit(MyPrinterState(devices: devices, device: connectedDevice));
  }

  void connect(device) async {
    emit(PrinterLoadingState());
    bluetooth.isConnected.then((isConnected) {
      if (!isConnected!) {
        bluetooth.connect(device);
        connectedDevice = device;
      }
    });
    emit(MyPrinterState(devices: devices, device: connectedDevice));
  }

  void printReceipt({
    required String company,
    required String name,
    required String address,
    required String package,
    required int price,
    required int debt,
    required String month,
    required String year,
    required String note,
    required double tax,
    required int rentCost,
    required int discount,
  }) {
    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        bluetooth.printNewLine();
        bluetooth.printCustom(company, 4, 1);
        bluetooth.printCustom(company, 2, 1);
        bluetooth.printLeftRight(
          DateFormat(dateFormat).format(DateTime.now()),
          DateFormat(timeFormat).format(DateTime.now()),
          1,
        );
        bluetooth.printNewLine();
        bluetooth.printCustom('Nama: $name', 1, 0);
        bluetooth.printCustom('Alamat: $address', 1, 0);
        bluetooth.printLeftRight('Broadband', package.trim(), 1);
        bluetooth.printLeftRight('Jatuh Tempo', '$month $year', 1);
        bluetooth.printLeftRight(
          'Harga',
          CurrencyFormat.convertToIdr(price, 0),
          1,
        );
        bluetooth.printLeftRight(
          'PPN ($tax%)',
          CurrencyFormat.convertToIdr(tax / 100 * price, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Hutang',
          CurrencyFormat.convertToIdr(debt, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Biaya Sewa',
          CurrencyFormat.convertToIdr(rentCost, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Diskon',
          CurrencyFormat.convertToIdr(discount, 0),
          1,
        );
        bluetooth.printLeftRight(
          'Total',
          CurrencyFormat.convertToIdr(
              tax > 0
                  ? (tax / 100 * price) + price + debt + rentCost - discount
                  : price + debt + rentCost - discount,
              0),
          1,
        );
        bluetooth.printNewLine();
        bluetooth.printCustom(note, 1, 0);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.paperCut();
      }
    });
  }
}

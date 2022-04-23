import 'package:intl/intl.dart';

const String dateTimeFormat = "EEEE, d MMMM yyyy HH:mm:ss";
const String dateFormat = "d MMM yyyy";
const String timeFormat = "HH:mm:ss";
const List<String> nameMonth = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }
}

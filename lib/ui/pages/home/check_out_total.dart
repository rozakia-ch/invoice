import 'package:flutter/material.dart';
import 'package:invoice/constants/constants.dart';
import 'package:invoice/hive/tax_hive.dart';

final TaxHive _taxHive = TaxHive();

class CheckOutTotal extends StatelessWidget {
  const CheckOutTotal({
    Key? key,
    required this.debt,
    required this.price,
  }) : super(key: key);
  final int debt;
  final int price;
  Future<double> _getTax() async {
    double tax = 0.0;
    await _taxHive.getFullTaxs().then((value) => tax = value.first.tax);
    return tax;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _getTax(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double _tax = snapshot.data!;
          double _priceTax = _tax / 100 * price;
          return CheckOutItemTotal(
            value: CurrencyFormat.convertToIdr(debt + price + _priceTax, 0),
          );
        } else {
          return CheckOutItemTotal(
            value: CurrencyFormat.convertToIdr(debt + price, 0),
          );
        }
      },
    );
  }
}

class CheckOutItemTotal extends StatelessWidget {
  const CheckOutItemTotal({Key? key, required this.value}) : super(key: key);
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total:',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

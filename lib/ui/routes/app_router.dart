import 'package:flutter/material.dart';
import 'package:invoice/ui/pages/home_page.dart';
import 'package:invoice/ui/pages/note_page.dart';
import 'package:invoice/ui/pages/price_page.dart';
import 'package:invoice/ui/pages/tax_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map? args = settings.arguments as Map?;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/price-page':
        return MaterialPageRoute(builder: (_) => const PricePage());
      case '/tax-page':
        return MaterialPageRoute(builder: (_) => const TaxPage());
      case '/note-page':
        return MaterialPageRoute(builder: (_) => const NotePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text('Error page')),
      );
    });
  }
}

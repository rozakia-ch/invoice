import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice/cubits/company/company_cubit.dart';
import 'package:invoice/cubits/note/note_cubit.dart';
import 'package:invoice/cubits/package/package_cubit.dart';
import 'package:invoice/cubits/tax/tax_cubit.dart';
import 'package:invoice/models/company/company_model.dart';
import 'package:invoice/models/note/note_model.dart';
import 'package:invoice/models/package/package_model.dart';
import 'package:invoice/models/tax/tax_model.dart';
import 'package:invoice/ui/pages/welcome_page.dart';
import 'package:invoice/ui/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<CompanyModel>(CompanyModelAdapter());
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Hive.registerAdapter<TaxModel>(TaxModelAdapter());
  Hive.registerAdapter<PackageModel>(PackageModelAdapter());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => CompanyCubit()..mapInitial(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => NoteCubit()..mapInitial(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => TaxCubit()..mapInitial(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => PackageCubit()..mapInitial(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invoice App',
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:invoice/cubits/note/note_cubit.dart';
import 'package:invoice/cubits/tax/tax_cubit.dart';
import 'package:invoice/models/tax/tax_model.dart';
import 'package:invoice/ui/pages/home_page.dart';
import 'package:invoice/ui/routes/app_router.dart';

import 'models/note/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Hive.registerAdapter<TaxModel>(TaxModelAdapter());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => NoteCubit()..mapInitial(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => TaxCubit()..mapInitial(),
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
      home: const HomePage(),
    );
  }
}

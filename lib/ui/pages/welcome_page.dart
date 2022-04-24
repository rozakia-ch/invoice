import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice/cubits/company/company_cubit.dart';
import 'package:invoice/cubits/note/note_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _firstSetup();
    super.initState();
  }

  _firstSetup() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
    final bool? setup = prefs.getBool('setup');
    if (setup == null) {
      prefs.setBool('setup', true);
      BlocProvider.of<CompanyCubit>(context).mapCompanyAdd(company: '');
      BlocProvider.of<NoteCubit>(context).mapNoteAdd(note: '');
    } else {
      Navigator.pushReplacementNamed(context, '/home-page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Invoice App'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home-page');
                },
                child: const Text("Lanjutkan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

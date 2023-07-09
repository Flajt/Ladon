import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ladon/features/otp/bloc/OtpBloc.dart';
import 'package:ladon/features/passwordGeneration/bloc/PasswordGeneratorBloc.dart';
import 'package:ladon/features/passwordManager/bloc/ViewPasswordsBloc.dart';
import 'package:ladon/features/passwordManager/uiblocks/PasswordEditingPage.dart';
import 'package:ladon/pages/HomePage.dart';
import 'package:ladon/pages/OtpPage.dart';
import 'package:ladon/pages/PasswordPage.dart';
import 'package:ladon/pages/SettingsPage.dart';
import 'package:ladon/pages/WelcomePage.dart';
import 'package:workmanager/workmanager.dart';

import 'features/settings/logic/BackupLogic.dart';
import 'pages/PasswordGenerationPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ViewPasswordBloc()),
        BlocProvider<PasswordGeneratorBloc>(
            create: (context) => PasswordGeneratorBloc()),
        BlocProvider(create: (context) => OtpBloc()),
      ],
      child: MaterialApp(
          routes: {
            "/addPasswordPage": (context) => const PasswordPage(),
            "/addOtpPage": (context) => const OtpPage(),
            "/editPasswordPage": (context) => const PasswordEditingPage(),
            "/welcomePage": (context) => const WelcomeScreen(),
            "/passwordGenerationPage": (context) =>
                const PasswordGenerationPage(),
            "/settingsPage": (context) => const SettingsPage()
          },
          title: 'Ladon',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoMonoTextTheme(
                const TextTheme(headline3: TextStyle(color: Colors.black))),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 65, 255, 65)),
            primaryColor: const Color.fromARGB(255, 65, 255, 65),
          ),
          home: const HomePage()),
    );
  }
}

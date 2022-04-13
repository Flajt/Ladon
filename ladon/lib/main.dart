import 'dart:convert';
import 'dart:io';

import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_autofill_service/flutter_autofill_service.dart';
import 'package:hive/hive.dart';
import 'package:ladon/features/passwordManager/logic/passwordManager.dart';
import 'package:ladon/features/passwordManager/uiblocks/PasswordEditingPage.dart';
import 'package:ladon/pages/HomePage.dart';
import 'package:ladon/pages/OtpPage.dart';
import 'package:ladon/pages/PasswordPage.dart';
import 'package:ladon/pages/WelcomePage.dart';
import 'package:ladon/shared/provider/OtpProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory? path = await getExternalStorageDirectory();
  Hive.init(path!.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        //TODO: Check if we it's sufficent to place it under HomePage.dart
        create: (context) => OtpProvider(),
        child: MaterialApp(
            routes: {
              "/addPasswordPage": (context) => const PasswordPage(),
              "/addOtpPage": (context) => OtpPage(),
              "/editPasswordPage": (context) => const PasswordEditingPage(),
              "/welcomePage": (context) => const WelcomeScreen()
            },
            title: 'Ladon',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 65, 255, 65)),
              primaryColor: const Color.fromARGB(255, 65, 255, 65),
            ),
            home: const HomePage()));
  }
}

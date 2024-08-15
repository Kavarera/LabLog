import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lab_log/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LabLog",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        textTheme: Typography().white,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
    ),
  );
}

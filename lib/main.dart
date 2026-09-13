import 'package:device_preview/device_preview.dart';
import 'package:financial_app_project/features/splash/app.dart';
import 'package:financial_app_project/services/user_data_service/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/features/locator.dart';

void main() async {
  setup();
   WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AppWidget(),
    ),
  );
}


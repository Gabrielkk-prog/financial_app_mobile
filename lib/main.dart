import 'package:device_preview/device_preview.dart';
import 'package:financial_app_project/features/splash/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/features/locator.dart';

void main() {
  setup();
  
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AppWidget(),
    ),
  );
}


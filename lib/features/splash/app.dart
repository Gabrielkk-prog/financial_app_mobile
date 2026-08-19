import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../../commom/themes/default_theme.dart';

import 'package:device_preview/device_preview.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: defautTheme,
      home: const SignUpPage(),
    );
  }
}
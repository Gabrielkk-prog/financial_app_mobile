//#1 here is the place where i can view the project in the device preview and also run the app in the real device.
//#2 so so, here we tell what is type of app we are going to run, in this case is a MaterialApp. 
import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:financial_app_project/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/features/onboarding/onboarding.page.dart';
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
      useInheritedMediaQuery: true,
      theme: defautTheme,
      home: const SignUpPage(),
    );
  }
}
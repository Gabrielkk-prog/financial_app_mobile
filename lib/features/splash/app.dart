import 'package:financial_app_project/features/home/home_page.dart';
import 'package:financial_app_project/features/onboarding/onboarding.page.dart';
import 'package:financial_app_project/features/sign_up/sign_in_page.dart';
import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:financial_app_project/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import '../../commom/themes/default_theme.dart';
import '../../commom/constants/routes.dart';

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
      initialRoute: NamedRoutes.splash,
      routes: {
        NamedRoutes.initial: (context)=> const OnboardingPage(),
        NamedRoutes.splash: (context) => const SplashPage(),
        NamedRoutes.signUp:(context) => const SignUpPage(),
        NamedRoutes.signIn:(context) => const SignInPage(),
        NamedRoutes.home: (context) => const HomePage(),
      },
    );
  }
}
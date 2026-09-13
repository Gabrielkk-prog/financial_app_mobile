import 'package:financial_app_project/features/home/home_page_view.dart';
import 'package:financial_app_project/features/onboarding/onboarding.page.dart';
import 'package:financial_app_project/features/sign_in/sign_in_page.dart';

import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:financial_app_project/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import '../../common/themes/default_theme.dart';
import '../../common/constants/routes.dart';

import 'package:device_preview/device_preview.dart';
import 'package:financial_app_project/features/profile/profile_page.dart';
import 'package:financial_app_project/features/stats/stats_page.dart';
import 'package:financial_app_project/features/stats/wallet/wallet.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: defautTheme,
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context)=> const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.signUp:(context) => const SignUpPage(),
        NamedRoute.signIn:(context) => const SignInPage(),
        NamedRoute.home: (context) => const HomePageView(),
        NamedRoute.stats: (context) => const StatsPage(),
        NamedRoute.wallet: (context) => const WalletPage(),
        NamedRoute.profile: (context) => const ProfilePage(),
      },
    );
  }
}
import 'package:financial_app_project/common/constants/routes.dart';
import 'package:financial_app_project/common/models/transaction_model.dart';
import 'package:financial_app_project/common/themes/default_theme.dart';
import 'package:financial_app_project/features/forgot_password/check_your_email_page.dart';
import 'package:financial_app_project/features/forgot_password/forgot_password_page.dart';
import 'package:financial_app_project/features/home/home_page_view.dart';
import 'package:financial_app_project/features/home/wallet/wallet_page.dart';
import 'package:financial_app_project/features/onboarding/onboarding.page.dart';
import 'package:financial_app_project/features/profile/profile_page.dart';
import 'package:financial_app_project/features/sign_in/sign_in_page.dart';
import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:financial_app_project/features/splash/splash_page.dart';
import 'package:financial_app_project/features/stats/stats_page.dart';
import 'package:financial_app_project/features/transaction/transaction_page.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme().defaultTheme,
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial: (context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.signUp: (context) => const SignUpPage(),
        NamedRoute.signIn: (context) => const SignInPage(),
        NamedRoute.home: (context) => const HomePageView(),
        NamedRoute.stats: (context) => const StatsPage(),
        NamedRoute.wallet: (context) => const WalletPage(),
        NamedRoute.profile: (context) => const ProfilePage(),
        NamedRoute.transaction: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          return TransactionPage(
            transaction: args != null ? args as TransactionModel : null,
          );
        },
        NamedRoute.forgotPassword: (context) => const ForgotPasswordPage(),
        NamedRoute.checkYourEmail: (context) => const CheckYourEmailPage(),
      },
    );
  }
}
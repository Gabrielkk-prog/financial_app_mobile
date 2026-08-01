//here is the place where i can view the project in the device preview and also run the app in the real device
import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/features/onboarding/onboarding.page.dart';
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

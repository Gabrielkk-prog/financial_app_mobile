//on this page I configure the onboading settings!
// ignore: unused_import
import 'dart:developer';

import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/commom/widgets/multi_text_button.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
// ignore: unused_import
import 'package:financial_app_project/features/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold( 
    backgroundColor: AppColors.iceWhite,
    body: SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 24.0,
      ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24.0),
            Center(
            child: SizedBox(
              height: 280.0,
              child: Image.asset(
                'assets/images/MyImage.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 24.0),

          Text(
            'Spend Smarter',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText.copyWith(
              color: AppColors.greenlightTwo,
            ),
          ),

          Text(
            'Save More',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText.copyWith(
              color: AppColors.greenlightTwo,
            ),
          ),

          const SizedBox(height: 24.0),

          PrimaryButton(
            text: 'Get Started',
            onPressed: () {
              Navigator.pushNamed(
                context,
                NamedRoutes.signUp,
              );
            },
          ),

          const SizedBox(height: 8.0),

          MultiTextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                NamedRoutes.signIn,
              );
            },
            children: [
              Text(
                'Already have account? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.lightGrey,
                ),
              ),
              Text(
                'Sign In',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
} }


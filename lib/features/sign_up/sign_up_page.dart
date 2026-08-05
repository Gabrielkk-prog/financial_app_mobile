import 'dart:developer';
import 'package:financial_app_project/commom/constants/app_colors.dart' show AppColors;
import 'package:financial_app_project/commom/constants/app_text_styles.dart' show AppTextStyles;
import 'package:financial_app_project/commom/widgets/custom_text_form_field.dart';
import 'package:financial_app_project/commom/widgets/multi_text_button.dart';
import 'package:financial_app_project/commom/widgets/password_form_field.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  
    final  formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Spend Smarter',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Save More',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  'assets/images/form.image.png',
                  height: 160,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      labelText: 'your name',
                      hintText: 'JOHN DOE',
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        print(value);
                        return null;
                      },
                    ),
                    PasswordFormField(
                      labelText: "choose your password",
                      hintText: "********",
                    ),
                    PasswordFormField(
                      labelText: "confirm your password",
                      hintText: "********",
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PrimaryButton(
                  text: 'Sign Up',
                  onPressed: (){
                   final valid = formKey.currentState?.validate(); 
                   log(valid.toString());     
                  },
              ),
              ),
              const SizedBox(height: 12),
              MultiTextButton(
                onPressed: () => log('tap'),
                children: [
                  Text(
                    'Already have account? ',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  Text(
                    'Log In',
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
  }
}


import 'dart:developer';

import 'package:financial_app_project/commom/constants/app_colors.dart' show AppColors;
import 'package:financial_app_project/commom/constants/app_text_styles.dart' show AppTextStyles;
import 'package:financial_app_project/commom/widgets/custom_text_form_field.dart';
import 'package:financial_app_project/commom/widgets/multi_text_button.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
        Text(
              'Spend Smarter', 
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
        ),
        ),
        Text (
              'Save More',
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
        ),
        ),
        Image.asset('assets/images/form.image.png'
                ),
        Form(                            // be careful my form borns here 
          child: Column(
            children: const [ 
               CustomTextFormField(
                labelText: "your name", 
                hintText: "John Doe",
               ),
              ],
             ),
            ),
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 16.0,
            bottom: 4.0,
          ),
          child: PrimaryButton(
            text: 'Sign Up',
            onPressed: () => log('tap'),
          ),
          ),
        MultiTextButton(
          onPressed: ()=> log('tap'),
          children: [
          Text(
            'Already have account? ',
            style: AppTextStyles.smallText.copyWith(
              color: AppColors.lightGrey,
            ),
            ),
            Text(
              'Log In' ,
              style: AppTextStyles.smallText.copyWith(
                color: AppColors.greenlightTwo,
           ),
          ),
         ],
        ),
       ]
      )
    );
  }
}


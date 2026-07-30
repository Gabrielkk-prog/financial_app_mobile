//on this page I configure the onboading settings!
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.iceWhite,
    body: Align(
        child: Column(
          children: [      // chlidren organize the widgets in a vertical layout by order of their appearance in the list
            const SizedBox(height: 48.0),
            Expanded(
              flex: 2,             // This container will take 2/3 of the available space
              child: Image.asset('assets/images/man.png.png'),
            ),
            Text('Spend Smarter', style: AppTextStyles.mediumText.copyWith(
              color: AppColors.greenlightTwo,
            ),
            ),
            Text ('Save More', style: AppTextStyles.mediumText.copyWith(
              color: AppColors.greenlightTwo,
            ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
                ),                   
              child: PrimaryButton(
                text: 'Get Started',
                onPressed: () {},       //turn on the grey color function 
              ),
            ),
                        
            Text (
              'Already have an account? Log In' , style: AppTextStyles.smallText.copyWith(
              color: AppColors.grey,
            ),
            ),
            const SizedBox(height: 24.0),
          ]
         )
      ),
    );
  }
}



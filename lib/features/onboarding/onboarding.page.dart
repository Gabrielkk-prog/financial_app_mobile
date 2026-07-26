import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        const SizedBox(height: 60.0),
        Expanded(
          flex: 2,             // This container will take 2/3 of the available space
         child: Container(
           color: AppColors.iceWhite,
           child: Image.asset('assets/images/man.png.png'),
        ),
      ),
          Text('Spend Smarter', style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
          ),
          ),
          Text ('Save More', style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
          )),
          Expanded(
            child: Container(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

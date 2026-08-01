//on this page I configure the onboading settings!
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.iceWhite,
    body: Column(  // ListView is a scrollable list of widgets arranged linearly   
      children: [      // chlidren organize the widgets in a vertical layout by order of their appearance in the list
        const SizedBox(height: 48.0),
         Expanded(
           child: Image.asset('assets/images/MyImage.png'
           ),
         ),
        Text('Spend Smarter', 
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
        ),
        ),
        Text ('Save More',
          textAlign: TextAlign.center,
          style: AppTextStyles.mediumText.copyWith(
            color: AppColors.greenlightTwo,
        ),
        ),
    
        MultiTextButton(
          onPressed: ()=> log('tap'),
          children: [
          Text(
            'Already have account? ',
            style: AppTextStyles.smallText.copyWith(
              color: AppColors.grey,
            ),
          ),
            Text(
              'Log In' ,
              style: AppTextStyles.smallText.copyWith(
                color: AppColors.greenlightTwo,
              ),
          )
        ],
        ),
        const SizedBox(
          height: 24.0),
      ],
     ),
    );
  }
}

class MultiTextButton extends StatelessWidget {
  final List<Text> children;
  final VoidCallback? onPressed;

  const MultiTextButton({
    super.key,
    required this.children,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
       child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center ,
        children: children,
           ),
          );
  }
}



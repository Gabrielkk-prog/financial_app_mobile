import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ 
            AppColors.greenlightOne,
            AppColors.greenlightTwo,    // the first two digits are for transparency
            
          ],
        ), 
      ), 
        child: Text(
          'financy',
          style: AppTextStyles.mediumText.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

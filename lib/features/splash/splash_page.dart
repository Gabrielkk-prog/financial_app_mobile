import 'dart:async';

import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/commom/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    init();
  }
                                   //when the app opens, he starts  whith the 
                                              //splashPage and then 
                                           //move on to onboardPage.
 

   Timer init(){                                                                    
    return Timer(Duration(seconds: 2),      
     navigateToOnboardig,
     );
   }
  
  void navigateToOnboardig(){
    Navigator.pushReplacementNamed(
      context,
      NamedRoutes.initial
    );
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'financy',
              style: AppTextStyles.mediumText.copyWith(
                color: AppColors.white,
              ),
            ),
            const CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

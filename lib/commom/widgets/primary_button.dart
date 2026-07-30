//This page is excusively for the first button settings!
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';


class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;              //VoidCallback recives a void fuction
  final String text;

  const PrimaryButton({
    super.key,
    this.onPressed,
    required this.text,   // this means that this propriaty must to be obrigatory 
  });

  final BorderRadius _borderRadius =               //I create a private border radius to reduce boiler plate
    const BorderRadius.all(Radius.circular(24.0));

  @override
  Widget build(BuildContext context) {
    return Ink(                           // I decided remove the material becouse the Ink already have this effect
    height: 48.0,
    decoration: BoxDecoration(
        borderRadius: _borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
             onPressed != null
             ? AppColors.greenGradient
             : AppColors.greyGradient,
          ),
      ),         // Spacing UP
         child: InkWell(
     borderRadius: _borderRadius,
     onTap: onPressed, 
     child: Align(
       child: Text (
        text,
         style: AppTextStyles.mediumText18.copyWith(
          color: AppColors.white)
               ),
     ),
         ),
        );
 }
}

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

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(38.0)),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(38.0)),
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
       borderRadius: const BorderRadius.all(Radius.circular(38.0)),
       onTap: onPressed, 
       child: Container(        // I need creat my own button because the default button is not customizable
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(38.0)
          ),
         alignment: Alignment.center,
         height: 64.0,
         child: Text (
          text,
           style: AppTextStyles.mediumText18.copyWith(
            color: AppColors.white)
          ),
         ),
       ),
     ),
   ),
  );
 }
}

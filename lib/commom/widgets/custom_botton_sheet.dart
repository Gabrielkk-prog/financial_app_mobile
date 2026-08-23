import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:flutter/material.dart';

void customModalBottomSheet(
  BuildContext context,{
    required String message,
  }) {
  showModalBottomSheet<void>(
    context: context, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(38.0),
        topRight: Radius.circular(38.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(38.0),
            topRight: Radius.circular(38.0),
          ),
        ),
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message,
               textAlign: TextAlign.center,
                style: AppTextStyles.mediumText20.copyWith(
                  color: AppColors.greenlightTwo,
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: PrimaryButton(
                  text: 'Tentar Novamente',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
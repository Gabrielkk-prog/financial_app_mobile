
import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:flutter/material.dart';

class customProgressIndicator extends StatelessWidget {
  const customProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.iceWhite,
        ),
    );
  }
}

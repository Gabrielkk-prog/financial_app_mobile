import 'dart:async';

import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/commom/widgets/custom_circular_progress_indicator.dart';
import 'package:financial_app_project/features/locator.dart';
import 'package:financial_app_project/features/splash/splash_controller.dart';
import 'package:financial_app_project/features/splash/splash_state.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashController _splashController;

  @override
  void initState() {
    super.initState();
    _splashController = locator.get<SplashController>();
    _splashController.addListener(_onStateChanged);
    _init();
  }

  void _onStateChanged() {
    if (_splashController.state is SplashStateSucces) {
      Navigator.pushReplacementNamed(context, NamedRoutes.home);
    } else if (_splashController.state is SplashStateError) {
      Navigator.pushReplacementNamed(context, NamedRoutes.initial);
    }
  }

  Timer _init() {
    return Timer(const Duration(seconds: 2), () {
      _splashController.isUserLogged();
    });
  }

  @override
  void dispose() {
    _splashController.removeListener(_onStateChanged);
    _splashController.dispose();
    super.dispose();
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
              AppColors.greenlightTwo,
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

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ 
          Color(0xFF63B5AF),   // the first two digits are for transparency
          Color(0xFF438883),
          ]) 
      ) 
    );
  }
}
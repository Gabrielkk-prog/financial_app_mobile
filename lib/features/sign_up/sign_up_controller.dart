import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:financial_app_project/features/sign_up/sign_up_stage.dart';

class SignUpController extends ChangeNotifier {
  SignUpStage _state = SignUpInitialStage();

  SignUpStage get state => _state;

  void _changeState(SignUpStage newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp() async {
    _changeState(SignUpLoadingStage());
    await Future.delayed(const Duration(seconds: 2));

    log('usuario logado');

    _changeState(SignUpSuccessStage());
    return true;
  } 
}
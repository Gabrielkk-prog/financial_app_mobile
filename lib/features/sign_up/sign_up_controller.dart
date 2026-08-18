import 'dart:developer';

import 'package:financial_app_project/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:financial_app_project/features/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;

  SignUpController(this._service);

  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp({
    required String name,
    required String email,
    required String password
     }) async {
    _changeState(SignUpLoadingState());
    try {
     _service.signUp(
      name: name,
      email:email,
      password: password
      );

      _changeState(SignUpSuccessState());
      return true;
    } catch (e) {
      _changeState(SignUpErrorState(message: e.toString()));
      return false;
    }
  } 
}
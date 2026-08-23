import 'package:financial_app_project/features/sign_up/sign_in_state.dart';
import 'package:financial_app_project/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier{
  final AuthService _service;

  SignInController({required this._service});

  SignInState _state = SignInStateInitial();

  SignInState get state => _state;

  void _changeState(SignInState newState){
    _state = newState;
    notifyListeners();
  }

   Future<void> signIn({
    required String email,
    required String password
     }) async {
    _changeState(SignInStateLoadingState());
    try {
     await _service.signIn(
      email:email,
      password: password
      );

      _changeState(SignInStateSuccessState());
    } catch (e) {
      _changeState(SignInStateErrorState(message: e.toString()));
    }
  } 
}


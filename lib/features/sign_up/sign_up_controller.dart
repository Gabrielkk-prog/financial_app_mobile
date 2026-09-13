import 'package:financial_app_project/services/auth_service/auth_service.dart';
import 'package:financial_app_project/services/user_data_service/secure_storage.dart';
import 'package:flutter/foundation.dart';


import 'sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpController({
    required AuthService authService,
    required SecureStorageService secureStorageService,
  })  : _secureStorageService = secureStorageService,
        _authService = authService;

  final AuthService _authService;
  final SecureStorageService _secureStorageService;

  SignUpState _state = SignUpStateInitial();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _changeState(SignUpStateLoading());

    try {
      final result = await _authService.signUp(
        name: name,
        email: email,
        password: password,
      );

      final error = result.error;
      if (error != null) {
        _changeState(SignUpStateError(error.message));
        return;
      }

      final data = result.data;
      if (data == null) {
        _changeState(SignUpStateError('Unable to create user'));
        return;
      }

      await _secureStorageService.write(
        key: "CURRENT_USER",
        value: data.toJson(),
      );

      _changeState(SignUpStateSuccess());
    } catch (error) {
      _changeState(SignUpStateError(error.toString()));
    }
  }
}
import 'package:financial_app_project/features/splash/splash_state.dart';
import 'package:financial_app_project/services/secure_storage.dart';
import 'package:flutter/foundation.dart';

// Here we'll verified if the user is logged.
class SplashController extends ChangeNotifier {
  final SecureStorage _service;

  SplashController(this._service);

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }

  // he will make sure the user has a count.
  Future<void> isUserLogged() async {
    final result = await _service.readOne(key: "CURRENT_USER");
    if (result != null) {
      _changeState(SplashStateSucces());
    } else {
      // if is a real user return succes, else return error.
      _changeState(SplashStateError());
    }
  }
}
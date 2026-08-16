import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:financial_app_project/features/sign_up/sign_up_state.dart';

class SignUpController extends ChangeNotifier {
  SignUpState _state = SignUpInitialState();

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<bool> doSignUp() async {
    _changeState(SignUpLoadingState());
    try {
    // PROBLEMA #11: Você usa Future.delayed(2 segundos) em vez de uma chamada REAL a uma API.
    // Em produção, deveria fazer um POST para seu backend com nome, email, senha.
    // SOLUÇÃO: Substitua Future.delayed por uma chamada real, ex: 
    // await _authService.signUp(name, email, password);
    // Receba name, email, password como parâmetros do método doSignUp().
    await Future.delayed(const Duration(seconds: 2));

    //throw Exception("erro ao logar");
    // PROBLEMA #12: A linha de throw está comentada. Se você quer testar erro, descomente.
    // Se quer que nunca lance erro, remova a linha comentada para deixar o código limpo.
    // SOLUÇÃO: Decida: ou a deixa comentada (documente por quê), ou a remova.
    log('usuario criado com sucesso');

    _changeState(SignUpSuccessState());
    return true;
    } catch (e) {
      // PROBLEMA #13: No catch, você muda para SignUpErrorState mas não passa a mensagem de erro.
      // Resultado: a página mostra "Erro ao cadastrar, tente novamente." genericamente.
      // SOLUÇÃO: Passe a mensagem de erro: _changeState(SignUpErrorState(message: e.toString()))
      // e depois mostre a mensagem específica na SnackBar ao invés de hardcoded.
      _changeState(SignUpErrorState());
      return false;
    }
  } 
}
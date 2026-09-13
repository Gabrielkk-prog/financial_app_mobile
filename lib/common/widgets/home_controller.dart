import 'package:financial_app_project/services/user_data_service/user_data_service.dart';
import 'package:flutter/material.dart';

import '../../common/models/models.dart';
import '../../repositories/repositories.dart';

import 'home_state.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required TransactionRepository transactionRepository,
    required this._userDataService,
  })  : _transactionRepository = transactionRepository;

  final TransactionRepository _transactionRepository;
  final UserDataService _userDataService;

  HomeState _state = HomeStateInitial();

  HomeState get state => _state;

  UserModel get userData => _userDataService.userData;

  late PageController _pageController;
  PageController get pageController => _pageController;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  set setPageController(PageController newPageController) {
    _pageController = newPageController;
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getLatestTransactions() async {
    _changeState(HomeStateLoading());

    final result = await _transactionRepository.getLatestTransactions();

    result.fold(
      (error) => _changeState(HomeStateError(message: error.message)),
      (data) {
        _transactions = data;
        _transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        _changeState(HomeStateSuccess());
      },
    );
  }

  Future<void> getUserData() async {
    _changeState(HomeStateLoading());
    final result = await _userDataService.getUserData();

    result.fold(
      (error) => _changeState(HomeStateError(message: error.message)),
      (data) => _changeState(HomeStateSuccess()),
    );
  }
}
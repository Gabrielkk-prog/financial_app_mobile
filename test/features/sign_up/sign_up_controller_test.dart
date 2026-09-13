import 'package:financial_app_project/common/models/user_model.dart';
import 'package:financial_app_project/common/constants/data/data_result.dart';
import 'package:financial_app_project/features/sign_up/sign_up_controller.dart';
import 'package:financial_app_project/features/sign_up/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/mock_classes.dart';

void main() {
  late SignUpController signUpController;
  late MockSecureStorage mockSecureStorage;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorage = MockSecureStorage();

    signUpController = SignUpController(
      authService: mockFirebaseAuthService,
      secureStorageService: mockSecureStorage,
    );

    user = UserModel(
      id:'1a2b3c4d5e',
      name:'User',
      email:'user@email.com',
      password:'user@123',
    );
    
  });

  test('deve iniciar em estado inicial', () {
    expect(signUpController.state, isInstanceOf<SignUpStateInitial>());
  });

  test('deve ir para sucesso ao cadastrar', () async {
    when(() => mockSecureStorage.write(
      key: 'CURRENT_USER',
      value: user.toJson(),
    )).thenAnswer((_) async {});

    when(() => mockFirebaseAuthService.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    )).thenAnswer((_) async => DataResult.success(user));

    await signUpController.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );

    expect(signUpController.state, isInstanceOf<SignUpStateSuccess>());
  });

  test('deve ir para erro ao falhar no cadastro', () async {
    when(() => mockFirebaseAuthService.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    )).thenThrow(Exception('Falha ao criar conta'));

    await signUpController.signUp(
      name: 'User',
      email: 'user@email.com',
      password: 'user@123',
    );

    expect(signUpController.state, isInstanceOf<SignUpStateError>());
  });
}
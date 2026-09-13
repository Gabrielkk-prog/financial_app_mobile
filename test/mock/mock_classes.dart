import 'package:financial_app_project/services/auth_service/auth_service.dart';
import 'package:financial_app_project/services/user_data_service/secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements SecureStorageService {}


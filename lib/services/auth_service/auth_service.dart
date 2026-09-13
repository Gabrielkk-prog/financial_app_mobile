import 'package:financial_app_project/common/constants/data/data_result.dart';


import '../../common/models/models.dart';

abstract class AuthService {
  Future<DataResult<UserModel>> signUp({
    String? name,
    required String email,
    required String password,
  });

  Future<DataResult<UserModel>> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<DataResult<String>> userToken();

  Future<DataResult<bool>> forgotPassword(String email);
}
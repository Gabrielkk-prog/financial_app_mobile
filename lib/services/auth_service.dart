import 'package:financial_app_project/commom/models/user_model.dart';
//the service pattern give us more flexibilit when building our security by screath
abstract class AuthService {
  Future <UserModel>signUp({
  String? name,
  required String email,
  required String password,
  });
  
  Future<UserModel>signIn({
    required String email,
    required String password,
  
  });
  Future<void> signOut();
}
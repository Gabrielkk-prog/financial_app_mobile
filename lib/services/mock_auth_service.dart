import 'package:financial_app_project/commom/models/user_model.dart';
import 'package:financial_app_project/services/auth_service.dart';

class MockAuthService implements AuthService{
  @override
  Future<dynamic> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp({
    String? name, 
    required String email,
    required String password
     }) async {
          await Future.delayed(const Duration(seconds: 2));
      try {
    if(password.startsWith('123')){
      throw Exception();
    }
     return UserModel(
      email.hashCode,
      name,
      email,
      password,
     );
      } catch(e) {
      if(password.startsWith('123')){
        throw 'Senha insegura. Digite uma senha forte' ;
      } 
      throw 'Não foi possivel criar sua conta nesse momento. Tente mais tarde' ;
      }
  }
}
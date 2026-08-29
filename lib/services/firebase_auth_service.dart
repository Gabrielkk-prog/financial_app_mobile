import 'package:financial_app_project/commom/models/user_model.dart';
import 'package:financial_app_project/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(
          result.user!.uid,
          result.user!.displayName,
          result.user!.email,
          password,
        );
      } else {
        throw Exception('Falha ao fazer login');
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Erro ao fazer login';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp({
    String? name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await result.user!.updateDisplayName(name ?? '');
        return UserModel(
          result.user!.uid,
          result.user!.displayName,
          result.user!.email,
          password,
        );
      } else {
        throw Exception('Falha ao criar conta');
      }
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Erro ao criar conta';
    } catch (e) {
      rethrow;
    }
  }
}

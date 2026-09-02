import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/services/secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await const SecureStorage().deleteOne(key: 'CURRENT_USER');
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      NamedRoutes.initial,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName?.trim();
    final email = user?.email ?? 'Usuário não identificado';

    // Dados exibidos diretamente da sessão atual do Firebase.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 44,
            backgroundColor: AppColors.iceWhite,
            child: Icon(Icons.person, size: 48, color: AppColors.green),
          ),
          const SizedBox(height: 20),
          Text(
            name?.isNotEmpty == true ? name! : 'Usuário',
            textAlign: TextAlign.center,
            style: AppTextStyles.mediumText20,
          ),
          const SizedBox(height: 4),
          Text(
            email,
            textAlign: TextAlign.center,
            style: AppTextStyles.smallText.copyWith(color: AppColors.green),
          ),
          const SizedBox(height: 32),
          Card(
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('E-mail'),
              subtitle: Text(email),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _signOut(context),
            icon: const Icon(Icons.logout),
            label: const Text('Sair da conta'),
          ),
        ],
      ),
    );
  }
}

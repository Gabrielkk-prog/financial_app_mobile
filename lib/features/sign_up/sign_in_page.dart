import 'dart:developer';
import 'package:financial_app_project/commom/constants/app_colors.dart' show AppColors;
import 'package:financial_app_project/commom/constants/app_text_styles.dart' show AppTextStyles;
import 'package:financial_app_project/commom/constants/routes.dart';
import 'package:financial_app_project/commom/widgets/custom_botton_sheet.dart';
import 'package:financial_app_project/commom/widgets/custom_text_form_field.dart';
import 'package:financial_app_project/commom/widgets/multi_text_button.dart';
import 'package:financial_app_project/commom/widgets/password_form_field.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:financial_app_project/features/locator.dart';
import 'package:financial_app_project/features/sign_up/sign_in_controller.dart';
// ignore: unused_import
import 'package:financial_app_project/features/sign_up/sign_up_controller.dart';
import 'package:financial_app_project/features/sign_up/sign_in_state.dart';
import 'package:financial_app_project/services/mock_auth_service.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}
 
class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _controller = locator.get<SignInController>();
  bool _isLoadingDialogVisible = false;

  @override
  void initState() { 
    super.initState();
    _controller.addListener(_onControllerStateChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerStateChanged);
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onControllerStateChanged() {
    if (!mounted) return;

    final state = _controller.state;

    if (state is SignInStateLoading) {
      _showLoadingDialog();
      return;
    }

    if (_isLoadingDialogVisible) {
      Navigator.of(context, rootNavigator: true).pop();
      _isLoadingDialogVisible = false;
    }

    if (state is SignInStateSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('nova Tela'),
            ),
          ),
        ),
      );
    }

    if (state is SignInStateError) {
      customModalBottomSheet(
        context,
        message: state.message,
      );
    }
  }

  void _showLoadingDialog() {
    if (_isLoadingDialogVisible) return;
    _isLoadingDialogVisible = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            24.0,
            12.0,
            24.0,
            12.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  'assets/images/signIn.image.png',
                  height: 160,
                ),
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              
              
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'your email',
                      hintText: 'john@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "esse campo nao pode ser vazio";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "email invalido";
                        }
                        return null;
                      },
                    ),
                    PasswordFormField(
                      controller: _passwordController,
                      labelText: 'your password',
                      hintText: '********',
                      helperText:
                          'Password must be at least 8 characters, 1 capital letter and 1 number.',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'esse campo nao pode ser vazio';
                        }
                        if (value.length < 8) {
                          return 'senha deve ter no mínimo 8 caracteres';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'senha deve conter pelo menos 1 letra maiúscula';
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'senha deve conter pelo menos 1 número';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: PrimaryButton(
                  text: 'Sign In',
                  onPressed: (){
                   final valid = _formKey.currentState != null && _formKey.currentState!.validate();
                   if (valid) {
                     final email = _emailController.text;
                     final password = _passwordController.text;
                     _controller.signIn(
                       email: email,
                       password: password,
                     );
                   } else {
                     log("formulario invalido");
                   }
                  },
              ),
              ),

              
                                           //when you tap the button,
                                                  //you back
                                             //to the signUp page.
              const SizedBox(height: 12),
              MultiTextButton(
                onPressed: () => Navigator.popAndPushNamed(
                context, 
                NamedRoutes.signUp,
                ),
                children: [
                  Text(
                    'Dont\'t have account? ',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.greenlightTwo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}


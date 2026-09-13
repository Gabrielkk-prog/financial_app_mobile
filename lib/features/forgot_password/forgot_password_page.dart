import 'dart:developer';

import 'package:financial_app_project/common/constants/app_colors.dart';
import 'package:financial_app_project/common/constants/app_text_styles.dart';
import 'package:financial_app_project/common/constants/keys.dart';
import 'package:financial_app_project/common/constants/routes.dart';
import 'package:financial_app_project/common/widgets/custom_botton_sheet.dart';
import 'package:financial_app_project/common/widgets/custom_circular_progress_indicator.dart';
import 'package:financial_app_project/common/widgets/custom_text_form_field.dart';
import 'package:financial_app_project/common/widgets/multi_text_button.dart';
import 'package:financial_app_project/common/widgets/primary_button.dart';
import 'package:financial_app_project/features/forgot_password/forgot_password_state.dart';
import 'package:financial_app_project/features/locator.dart';
import 'package:financial_app_project/features/utils/validator.dart';
import 'package:flutter/material.dart';

import 'forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with CustomModalSheetMixin {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _forgotPasswordController = locator.get<ForgotPasswordController>();

  @override
  void initState() {
    super.initState();

    _forgotPasswordController.addListener(_handleForgotPasswordStateChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _forgotPasswordController.dispose();
    super.dispose();
  }

  void _onSendLinkButtonPressed() {
    final valid =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (valid) {
      _forgotPasswordController.forgotPassword(_emailController.text);
    } else {
      log("erro ao resetar a senha");
    }
  }

  void _handleForgotPasswordStateChange() {
    final state = _forgotPasswordController.state;
    switch (state.runtimeType) {
      case ForgotPasswordStateLoading:
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
        break;
      case ForgotPasswordStateSuccess:
        Navigator.popAndPushNamed(
          context,
          NamedRoute.checkYourEmail,
        );
        break;
      case ForgotPasswordStateError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_forgotPasswordController.state as ForgotPasswordStateError)
              .message,
          buttonText: "Try again",
          onPressed: () => Navigator.pop(context),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: ListView(
          children: [
            Text(
              'Reset Your\nPassword',
              textAlign: TextAlign.center,
              style: AppTextStyles.mediumText36.copyWith(
                color: AppColors.greenOne,
              ),
            ),
            Image.asset('assets/images/forgot_password_image.png'),
            Text(
              'Enter your email address and a link will be sent to reset your password.',
              style: AppTextStyles.mediumText16w500
                  .apply(color: AppColors.darkGrey),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Form(
                key: _formKey,
                child: CustomTextFormField(
                  key: Keys.forgotPasswordEmailField,
                  padding: EdgeInsets.zero,
                  controller: _emailController,
                  labelText: "your email",
                  hintText: "john@email.com",
                  validator: Validator.validateEmail,
                ),
              ),
            ),
            PrimaryButton(
              key: Keys.forgotPasswordSendLinkButton,
              text: 'Send Link',
              onPressed: _onSendLinkButtonPressed,
            ),
            MultiTextButton(
              key: const Key('forgotPasswordSignUpButton'),
              onPressed: () => Navigator.popAndPushNamed(
                context,
                NamedRoute.signUp,
              ),
              children: [
                Text(
                  'Don\'t have account? ',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                Text(
                  'Sign Up',
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.greenOne,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
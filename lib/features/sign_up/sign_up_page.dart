import 'dart:developer';
import 'package:financial_app_project/commom/constants/app_colors.dart' show AppColors;
import 'package:financial_app_project/commom/constants/app_text_styles.dart' show AppTextStyles;
import 'package:financial_app_project/commom/widgets/custom_circular_progress_indicator.dart';
// PROBLEMA #14: Você importa custom_circular_progress_indicator mas o usa como customProgressIndicator()
// com 'c' minúscula. Verificar se o nome da classe REALMENTE está neste formato.
// Se o arquivo define class CustomCircularProgressIndicator, use const CustomCircularProgressIndicator()
// Possível erro de compilação por case-sensitive ou importação errada.
import 'package:financial_app_project/commom/widgets/custom_text_form_field.dart';
import 'package:financial_app_project/commom/widgets/multi_text_button.dart';
import 'package:financial_app_project/commom/widgets/password_form_field.dart';
import 'package:financial_app_project/commom/widgets/primary_button.dart';
import 'package:financial_app_project/features/sign_up/sign_up_controller.dart';
import 'package:financial_app_project/features/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
 
class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _controller = SignUpController();
  bool _isLoadingDialogVisible = false;

  // PROBLEMA #1: O listener adicionado aqui é uma closure ANÔNIMA, mas em dispose() você tenta remover
  // _onControllerStateChanged (uma função nomeada diferente). O listener anônimo NUNCA será removido, causando
  // memory leak. SOLUÇÃO: Use _onControllerStateChanged em vez de uma closure anônima, ou guarde a referência
  // da closure e remova ela em dispose(). VV
  @override
  void initState() {
    super.initState();
    // PROBLEMA #2: Você está abrindo múltiplos diálogos sem verificar _isLoadingDialogVisible.
    // SOLUÇÃO: Remova essa closure anônima e use _controller.addListener(_onControllerStateChanged) em seu lugar,
    // assim você reutiliza o método _onControllerStateChanged que já verifica _isLoadingDialogVisible.
    _controller.addListener(_onControllerStateChanged);
      (){
        if (_controller.state is SignUpLoadingState) {
          showDialog(context: context,
          builder: (context)=> const customProgressIndicator(),
          );
      }
      };
  }

  @override
  void dispose() {
    // PROBLEMA #3: Você está tentando remover _onControllerStateChanged, mas o listener de verdade
    // adicionado em initState() é uma closure anônima. Isso significa o listener NUNCA é removido.
    // Resultado: quando sair dessa tela e voltar, múltiplos listeners serão acumulados.
    // SOLUÇÃO: Mude initState() para usar _controller.addListener(_onControllerStateChanged)
    // DEPOIS mude a closure anônima para realmente chamá-lo.
    _controller.removeListener(_onControllerStateChanged);
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onControllerStateChanged() {
    if (!mounted) return;

    final state = _controller.state;

    if (state is SignUpLoadingState) {
      _showLoadingDialog();
      return;
    }

    if (_isLoadingDialogVisible) {
      Navigator.of(context, rootNavigator: true).pop();
      _isLoadingDialogVisible = false;
    }

    if (state is SignUpSuccessState) {
      // PROBLEMA #4: Você chama Navigator.pop(context) ANTES de Navigator.push().
      // O pop() tenta fechar a tela ATUAL (SignUpPage), não o diálogo de loading!
      // Resultado: você pode estar saindo da tela de sign-up antes de mostrar "nova Tela".
      // SOLUÇÃO: Use Navigator.of(context, rootNavigator: true).pop() para fechar SÓ o diálogo,
      // OU guarde a referência do dialog ID e feche apenas ele.
      Navigator.pop(context);
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

    if (_controller.state is SignUpErrorState){
      // PROBLEMA #15: Você chama customModalBottonSheet(context) mas este método não está importado!
      // Resultado: erro de compilação "undefined_name customModalBottonSheet".
      // SOLUÇÃO: Importe a função/widget correto, ex: 
      // import 'package:financial_app_project/commom/widgets/custom_bottom_sheet.dart';
      // Ou remova a chamada se não quer usar modal bottom sheet ainda.
      Navigator.pop(context);
      customModalBottonSheet(context);
    }
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
                'Spend Smarter',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Save More',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText.copyWith(
                  color: AppColors.greenlightTwo,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Image.asset(
                  'assets/images/form.image.png',
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
                      labelText: 'your name',
                      hintText: 'JOHN DOE',
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        // PROBLEMA #5: Você está usando print() dentro do validator.
                        // print() NÃO deve ser usado em código de produção (o analyzer avisa: avoid_print).
                        // SOLUÇÃO: Remova o print() ou use log() do package dart:developer em seu lugar.
                        if (value != null && value.isEmpty) {
                          return "esse campo nao pode ser vazio";
                        }
                        print(value);
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      labelText: 'your email',
                      hintText: 'john@gmail.com',
                      textCapitalization: TextCapitalization.characters,
                      validator: (value) {
                        // PROBLEMA #6: Email está com TextCapitalization.characters (força MAIÚSCULA).
                        // Emails NUNCA devem estar em MAIÚSCULA. Além disso, não há validação de email real
                        // (regex ou package validator). SOLUÇÃO: Remova TextCapitalization ou use .none,
                        // e adicione validação real de email format.
                        if (value != null && value.isEmpty) {
                          return "esse campo nao pode ser vazio";
                        }
                        print(value);
                        return null;
                      },
                    ),
                    PasswordFormField(
                      labelText: 'choose your password',
                      hintText: '********',
                      helperText:
                          'Password must be at least 8 characters, 1 capital letter and 1 number.',
                      validator: (value) {
                        // PROBLEMA #7: Senha não tem TextEditingController associado.
                        // Sem controller, não há como recuperar o valor em doSignUp() para validar força de senha
                        // ou enviar para backend. SOLUÇÃO: Adicione um controller e passe para PasswordFormField.
                        // PROBLEMA #8: Validator diz "Password must be at least 8 characters, 1 capital letter and 1 number"
                        // mas o code NÃO valida isso! Você só checa se está vazio.
                        // SOLUÇÃO: Implemente regex ou ValidatorService para validar força de senha conforme mensagem.
                        if (value != null && value.isEmpty) {
                          return 'esse campo nao pode ser vazio';
                        }
                        print(value);
                        return null;
                      },
                    ),
                    PasswordFormField(
                      labelText: "confirm your password",
                      hintText: "********",
                      validator: (value) {
                        // PROBLEMA #9: Confirmação de senha não compara com o campo de senha anterior.
                        // O validator diz "não pode ser vazio" mas NÃO verifica se password === confirmPassword.
                        // SOLUÇÃO: Use um controller para o campo de senha, compare ele com este field usando
                        // textInputAction e valide se são iguais. Ou use um custom validator que acesse
                        // _formKey.currentState?.fields para comparar.
                        if (value != null && value.isEmpty) {
                          return "esse campo nao pode ser vazio";
                        }
                        print(value);
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
                  text: 'Sign Up',
                  onPressed: (){
                   // PROBLEMA #10: Você valida o form e chama doSignUp(), mas os valores dos campos
                   // NÃO são extraídos e passados para o controller. Os TextEditingController dos campos
                   // não são salvos em variáveis para acesso posterior.
                   // SOLUÇÃO: Extraia os valores usando _formKey.currentState?.fields, ou associe controllers
                   // aos fields e recupere .text deles ANTES de chamar doSignUp(). Depois passe os valores
                   // como parâmetros: _controller.doSignUp(name, email, password).
                   final valid = _formKey.currentState!= null && _formKey.currentState!.validate(); 
                   if(valid){
                    _controller.doSignUp();
                   }else {
                    log("erro ao logar");
                  }  
                  },
              ),
              ),
              const SizedBox(height: 12),
              MultiTextButton(
                onPressed: () => log('tap'),
                children: [
                  Text(
                    'Already have account? ',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  Text(
                    'Log In',
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

  void customModalBottonSheet(BuildContext context) {}
}


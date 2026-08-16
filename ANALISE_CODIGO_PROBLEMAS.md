# Análise Completa do Código - Problemas Identificados

## Resumo dos Problemas (15 no total)

### CRÍTICOS (Impedem compilação/funcionamento)

**PROBLEMA #1 e #2 - Listener anônimo em initState() não é removido (Memory Leak)**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linhas 29-38)
- **O que está errado:** Você adiciona um listener com uma closure ANÔNIMA, mas tenta remover `_onControllerStateChanged` em dispose()
- **Por que:** O listener adicionado não é removido, causando memory leak quando sair e voltar à página. Além disso, múltiplos diálogos podem ser abertos
- **Como corrigir:** Mude initState() para `_controller.addListener(_onControllerStateChanged)` ao invés de closure anônima

**PROBLEMA #3 - Mismatch entre listener adicionado e removido**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 45)
- **O que está errado:** removeListener(_onControllerStateChanged) não remove a closure anônima
- **Por que:** Listener anônimo e listener nomeado são referências diferentes
- **Como corrigir:** Sincronize initState() e dispose() para usarem o mesmo listener

**PROBLEMA #4 - Navigator.pop() fecha a tela errada**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 66-68)
- **O que está errado:** Você chama Navigator.pop(context) que fecha a SignUpPage, depois tenta fazer push para nova tela
- **Por que:** pop() tira a tela de sign-up do stack, então não há contexto para fazer push
- **Como corrigir:** Use `Navigator.of(context, rootNavigator: true).pop()` para fechar SÓ o diálogo de loading

**PROBLEMA #14 - Nome de classe inconsistente (case-sensitive)**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 30)
- **O que está errado:** Você usa `customProgressIndicator()` (minúscula) mas provavelmente importou `CustomCircularProgressIndicator` (maiúscula)
- **Por que:** Dart é case-sensitive. Erro de compilação provável
- **Como corrigir:** Use `const CustomCircularProgressIndicator()` ou ajuste conforme o nome real da classe

**PROBLEMA #15 - Função não importada**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 75)
- **O que está errado:** Você chama `customModalBottonSheet(context)` mas ela não está importada
- **Por que:** Erro undefined_name, compilação falha
- **Como corrigir:** Adicione a importação ou remova a chamada por enquanto

---

### LÓGICOS/DE DESIGN (Funcionam mas com falhas)

**PROBLEMA #5 - print() em código de produção**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linhas 127, 138, 149, 160, 170)
- **O que está errado:** Você usa print() em validators e onPressed
- **Por que:** Flutter analyzer avisa "avoid_print". Em produção, isso deixa outputs no console
- **Como corrigir:** Remova print() ou use `log()` do `dart:developer`

**PROBLEMA #6 - Email com TextCapitalization.characters**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 142)
- **O que está errado:** Email é convertido para MAIÚSCULA (JOHN@GMAIL.COM)
- **Por que:** Emails devem ser lowercase para validação e backend. Maiúscula quebra padrão de email
- **Como corrigir:** Remova TextCapitalization ou use `.none`

**PROBLEMA #7 - Senha sem TextEditingController**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 153)
- **O que está errado:** Campo de password não tem controller associado
- **Por que:** Sem controller, você não consegue recuperar o valor da senha em doSignUp() para enviar ao backend
- **Como corrigir:** Crie `final _passwordController = TextEditingController()` e passe para o field

**PROBLEMA #8 - Validator diz X mas valida Y**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 151)
- **O que está errado:** helperText diz "Password must be at least 8 characters, 1 capital letter and 1 number" mas o código só checa se está vazio
- **Por que:** Promessa ao usuário não cumprida
- **Como corrigir:** Implemente regex ou ValidatorService que realmente valida força de senha

**PROBLEMA #9 - Confirmação de senha não compara**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 165)
- **O que está errado:** Campo "confirm your password" não verifica se é igual ao campo "choose your password"
- **Por que:** Usuário pode digitar senhas diferentes e submeter
- **Como corrigir:** Use validators que comparem os dois campos usando Form.of(context).fields

**PROBLEMA #10 - Valores dos campos não são extraídos**
- **Arquivo:** `lib/features/sign_up/sign_up_page.dart` (linha 176)
- **O que está errado:** Você valida e chama doSignUp() mas não passa os valores (name, email, password)
- **Por que:** O controller não tem acesso aos valores do formulário
- **Como corrigir:** Extraia values usando controllers ou formKey.currentState?.fields, depois passe: `_controller.doSignUp(name, email, password)`

---

### CONTROLER

**PROBLEMA #11 - Simulação em vez de API real**
- **Arquivo:** `lib/features/sign_up/sign_up_controller.dart` (linha 17)
- **O que está errado:** Você usa `Future.delayed(2 segundos)` em vez de chamar um backend real
- **Por que:** Quando mudar para produção, precisará de uma API real
- **Como corrigir:** Adicione injeção de dependência (AuthService/SignUpService) e chame API real com os parâmetros

**PROBLEMA #12 - Linha de throw comentada**
- **Arquivo:** `lib/features/sign_up/sign_up_controller.dart` (linha 19)
- **O que está errado:** `//throw Exception("erro ao logar");` deixada como documentação?
- **Por que:** Código confuso - não fica claro se é intencional ou esquecido
- **Como corrigir:** Remova a linha ou documente por quê está comentada

**PROBLEMA #13 - Erro genérico sem mensagem específica**
- **Arquivo:** `lib/features/sign_up/sign_up_controller.dart` (linha 25)
- **O que está errado:** SignUpErrorState não recebe mensagem de erro, apenas muda estado
- **Por que:** SnackBar mostra "Erro ao cadastrar, tente novamente." genérico sem saber qual foi o erro
- **Como corrigir:** Modifique SignUpErrorState para receber mensagem: `SignUpErrorState(String this.message)` e use em SnackBar

---

## Arquivos com Comentários Adicionados

✅ `lib/features/sign_up/sign_up_page.dart` - 15 problemas comentados  
✅ `lib/features/sign_up/sign_up_controller.dart` - 3 problemas comentados  
✅ `lib/commom/widgets/custom_text_form_field.dart` - 1 sugestão comentada  

---

## Próximos Passos Recomendados (na ordem)

1. Corriga os CRÍTICOS primeiro (#1-4, #14-15) - impedem compilação
2. Depois os LÓGICOS (#5-13) - quebram funcionalidade
3. Depois refatore doSignUp() para receber parâmetros

---

**Data da análise:** 2026-08-16  
**Analisador:** GitHub Copilot

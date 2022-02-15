import 'package:flutter/material.dart';
import 'package:list_of_products/app/presentations/screens/login/login_screen.dart';
import 'package:list_of_products/app/presentations/screens/register_user/register_controller.dart';
import 'package:list_of_products/app/presentations/widgets/information_error_widget.dart';
import 'package:list_of_products/app/presentations/widgets/custom_text_field_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Consumer<RegisterController>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFieldWidget(
                  hintText: 'Nome',
                  controller: value.nameController,
                  errorText:
                      value.errorText(value.nameIsValid, value.nameError),
                ),
                const SizedBox(height: 25),
                CustomTextFieldWidget(
                  hintText: 'E-mail',
                  controller: value.emailController,
                  textInputType: TextInputType.emailAddress,
                  errorText:
                      value.errorText(value.emailIsValid, value.emailError),
                ),
                const SizedBox(height: 25),
                CustomTextFieldWidget(
                  hintText: 'Senha',
                  controller: value.passwordController,
                  textInputType: TextInputType.visiblePassword,
                  errorText: value.errorText(
                      value.passwordIsValid, value.passwordError),
                ),
                const SizedBox(height: 25),
                CustomTextFieldWidget(
                  hintText: 'Senha novamente',
                  controller: value.confirmPasswordController,
                  textInputType: TextInputType.visiblePassword,
                  errorText: value.errorText(
                      value.confirmPasswordIsValid, value.confirmPasswordError),
                ),
                const SizedBox(height: 25),
                value.showError
                    ? const InformationErrorWidget(
                        text: 'Erro ao cadastrar usuario')
                    : Container(),
                ElevatedButton(
                  onPressed: () async {
                    final result = await value.onPressed();
                    if (result) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: value.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

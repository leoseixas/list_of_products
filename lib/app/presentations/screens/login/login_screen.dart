import 'package:flutter/material.dart';
import 'package:list_of_products/app/presentations/screens/home/home_screen.dart';
import 'package:list_of_products/app/presentations/screens/login/login_controller.dart';
import 'package:list_of_products/app/presentations/screens/register_user/register_screen.dart';
import 'package:list_of_products/app/presentations/widgets/custom_text_field_widget.dart';
import 'package:list_of_products/app/presentations/widgets/information_error_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xff1E7494),
              Color(0xff43B7E0),
            ],
          ),
        ),
        child: Center(child: Consumer<LoginController>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  color: Colors.white38,
                  elevation: 15,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomTextFieldWidget(
                          hintText: 'E-mail',
                          controller: value.emailController,
                          textInputType: TextInputType.emailAddress,
                          fillColor: Colors.white38,
                          errorText: value.errorText(
                              value.emailIsValid, value.emailError),
                        ),
                        const SizedBox(height: 25),
                        CustomTextFieldWidget(
                          hintText: 'Senha',
                          controller: value.passwordController,
                          textInputType: TextInputType.visiblePassword,
                          fillColor: Colors.white38,
                          errorText: value.errorText(
                              value.passwordIsValid, value.passwordError),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                value.clearControllersRegister();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Cadastre-se',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        value.showError
                            ? InformationErrorWidget(text: value.errorLogin)
                            : Container(),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await value.onPressed();
                            if (result) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1E7494),
                            ),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            child: value.isLoading
                                ? CircularProgressIndicator()
                                : Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}

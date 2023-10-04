import 'package:ani_life/components/my_button.dart';
import 'package:ani_life/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_text_field.dart';
import '../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final petNameController = TextEditingController();

  //sing up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Пароли не совпадают")),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: (Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: usernameController,
                            hintText: "Имя пользователя",
                            obscureText: false,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: passwordController,
                            hintText: "Пароль",
                            obscureText: true,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: confirmPasswordController,
                            hintText: "Повторите пароль",
                            obscureText: true,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: petNameController,
                            hintText: "Кличка питомца",
                            obscureText: false,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        text: "Регистрация",
                        onTap: signUp,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Уже есть аккаунт?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                          SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              "Войти",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}

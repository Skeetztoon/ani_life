import 'package:ani_life/core/ui_kit/widgets/my_button.dart';
import 'package:ani_life/core/ui_kit/widgets/my_text_field.dart';
import 'package:ani_life/features/auth/data_domain/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _petNameController.dispose();
    super.dispose();
  }

  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _petNameController = TextEditingController();

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
                    MyTextField(
                      controller: _usernameController,
                      hintText: "Имя пользователя",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: _emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: _passwordController,
                      hintText: "Пароль",
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: _confirmPasswordController,
                      hintText: "Повторите пароль",
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                      controller: _petNameController,
                      hintText: "Кличка питомца",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final auth = ref.watch(authenticationProvider);

                        Future<void> signUp() async {
                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Пароли не совпадают"),
                              ),
                            );
                            return;
                          }
                          await auth.signUpWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                            _usernameController.text,
                            _petNameController.text,
                            context,
                          );
                        }

                        return MyButton(
                          text: "Регистрация",
                          onTap: signUp,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Уже есть аккаунт?",
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                        ),
                        const SizedBox(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

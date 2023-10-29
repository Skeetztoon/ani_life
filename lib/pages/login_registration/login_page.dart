import 'package:ani_life/components/my_button.dart';
import 'package:ani_life/components/my_text_field.dart';
import 'package:ani_life/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
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
                  const Icon(
                    Icons.accessible_forward,
                    size: 150,
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                            controller: emailController,
                            hintText: "Email",
                            obscureText: false,
                          )),
                      const SizedBox(height: 15),
                      SizedBox(
                          width: 320,
                          child: MyTextField(
                              controller: passwordController,
                              hintText: "Пароль",
                              obscureText: true)),
                      const SizedBox(height: 20),
                      MyButton(
                        text: "Войти",
                        onTap: signIn,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Нет аккаунта?",
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
                              "Зарегистрируйтесь!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ])),
          ),
        ),
      ),
    );
  }
}

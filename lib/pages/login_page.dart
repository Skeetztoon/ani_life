import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        width: 250,
                        child: TextField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                          decoration:  InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Email",
                          ),
                        )),
                    const SizedBox(height: 15),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: MyPrimaryColor, width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.remove_red_eye, color: MyPrimaryColor,),
                            hintText: "Пароль",
                          ),
                        )),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                                203, 99, 99, 1), // Background color
                            // onPrimary: Colors.amber, // Text Color (Foreground color)
                          ),
                          onPressed: () {},
                          child: Text(
                            "Войти",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ),
                  ],
                )
              ])),
        ),
      ),
    );
  }
}

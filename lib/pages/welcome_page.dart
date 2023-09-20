import 'package:ani_life/pages/login_page.dart';
import 'package:ani_life/pages/reg_person_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(
                                203, 99, 99, 1), // Background color
                            // onPrimary: Colors.amber, // Text Color (Foreground color)
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text(
                            "Войти",
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 3,
                                color: Color.fromRGBO(203, 99, 99, 1)),
                            backgroundColor: Colors.white, // Background color
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegPersonPage()));
                          },
                          child: Text(
                            "Регистрация",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Color.fromRGBO(203, 99, 99, 1)),
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

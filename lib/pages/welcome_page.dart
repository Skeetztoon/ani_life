import 'package:ani_life/pages/login_page.dart';
import 'package:ani_life/pages/register_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool shouldShowLogin = true;

  void togglePages() {
    setState(() {
      shouldShowLogin = !shouldShowLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
   if (shouldShowLogin) {
     return LoginPage(onTap: togglePages);
   } else {
     return RegisterPage(onTap: togglePages);
   }
  }
}

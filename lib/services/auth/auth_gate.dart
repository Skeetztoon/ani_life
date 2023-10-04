import 'package:ani_life/pages/home_page.dart';
import 'package:ani_life/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (content, snapshot) {
          // is user logged in
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}

import 'package:ani_life/pages/main_pages/map_page.dart';
import 'package:ani_life/pages/login_registration/welcome_page.dart';
import 'package:ani_life/pages/main_pages/init_page.dart';
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
            // return const HomePage();
            return const InitialPage();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}

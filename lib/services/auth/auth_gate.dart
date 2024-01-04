import 'package:ani_life/pages/login_registration/loading_Screen.dart';
import 'package:ani_life/pages/login_registration/welcome_page.dart';
import 'package:ani_life/pages/main_pages/init_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/login_registration/error_Screen.dart';
import 'auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return Scaffold(
    //   body: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (content, snapshot) {
    //       // is user logged in
    //       if (snapshot.hasData) {
    //         // return const HomePage();
    //         return const InitialPage();
    //       } else {
    //         return const WelcomePage();
    //       }
    //     },
    //   ),
    // );
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) return const InitialPage();
          return const WelcomePage();
        },
        loading: () => const LoadingScreen(),
        error: (e, stackTrace) => ErrorScreen(e, stackTrace));
  }
}

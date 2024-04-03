import 'package:ani_life/features/auth/data_domain/auth_provider.dart';
import 'package:ani_life/core/ui_kit/screens/error_screen.dart';
import 'package:ani_life/core/ui_kit/screens/loading_screen.dart';
import 'package:ani_life/features/auth/presentation/welcome_page.dart';
import 'package:ani_life/init_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const InitialPage();
        return const WelcomePage();
      },
      loading: () => const LoadingScreen(),
      error: (e, stackTrace) => ErrorScreen(e, stackTrace),
    );
  }
}

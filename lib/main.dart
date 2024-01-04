import 'package:ani_life/firebase_options.dart';
import 'package:ani_life/services/auth/auth_gate.dart';
import 'package:ani_life/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/login_registration/error_Screen.dart';
import 'pages/login_registration/loading_Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AniLife',
      theme: basicTheme(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: initialize.when(
          data: (data) {
            return const AuthGate();
          },
          loading: () => const LoadingScreen(),
          error: (e, stackTrace) => ErrorScreen(e, stackTrace)),
    );
  }
}

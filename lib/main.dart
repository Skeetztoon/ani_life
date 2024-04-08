import 'package:ani_life/features/auth/data_domain/auth_gate.dart';
import 'package:ani_life/core/ui_kit/screens/error_screen.dart';
import 'package:ani_life/core/ui_kit/screens/loading_screen.dart';
import 'package:ani_life/firebase_options.dart';
import 'package:ani_life/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

Logger logger = Logger('AppLogger');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen(
    (record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    },
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
      ],
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: initialize.when(
        data: (data) {
          return const AuthGate();
        },
        loading: () => const LoadingScreen(),
        error: (e, stackTrace) => ErrorScreen(e, stackTrace),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_nv2/views/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('pt', 'BR'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
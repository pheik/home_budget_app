import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl_standalone.dart';

import 'home.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await findSystemLocale();

  // Initialize Hive.
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('categories');
  await Hive.openBox('expenses');

  runApp(const MyApp());
}

/// Class for defining the localization, theme and the landing page of the
/// application.
class MyApp extends StatelessWidget {
  /// Widget for defining the localization, theme and the landing page of the
  /// application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Home Budget App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color.fromRGBO(145, 240, 0, 1)),
        textTheme: TextTheme()
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );

  }
}
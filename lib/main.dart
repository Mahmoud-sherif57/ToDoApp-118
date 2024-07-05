import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'to_do_app.dart';

void main() async {
  // to enable localisation
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales:  [Locale('en'),Locale('ar')],
      path: 'assets/translation',
      fallbackLocale:Locale('en') ,
      child: ToDoApp(),
    ),
  );
}


/// to generate keys file for localization
///flutter pub run easy_localization:generate -S assets/translation -O lib/view-model/utils -o local_keys.g.dart -f keys
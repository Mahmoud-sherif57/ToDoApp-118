import 'package:ToDoApp/to_do_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ToDoApp/view-model/data/local/shared_helper.dart';
import 'package:ToDoApp/view-model/localization/localization.dart';


void main() async {
  // to enable localisation
  WidgetsFlutterBinding.ensureInitialized();
  // initialize localization
  await EasyLocalization.ensureInitialized();
  // initialize shared helper
  await SharedHelper.init();
  // initialize firebase

  runApp(
    EasyLocalization(
      supportedLocales: Localization.locales,
      path: 'assets/translation',
      fallbackLocale:Localization.locales.first,
      child: const ToDoApp(),
    ),
  );
}


// to upgrade all the packages
// flutter pub upgrade --major-versions



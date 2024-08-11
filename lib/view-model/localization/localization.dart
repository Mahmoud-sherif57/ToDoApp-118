import 'package:flutter/material.dart';

 sealed class Localization {
  static const List<Locale> _locales = [Locale('en'), Locale('ar')];


// to access the private locales using getter  ..
  static List<Locale> get locales => _locales ;
}



/// to generate keys file for localization
///flutter pub run easy_localization:generate -S assets/translation -O lib/view-model/localization -o local_keys.g.dart -f keys
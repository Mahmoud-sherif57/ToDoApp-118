import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  //  (1)  (translationIcon)
  static translationIcon(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (context.locale.toString() == 'en') {
            context.setLocale(const Locale('ar'));
          } else {
            // it means that the local is "ar" so set the local to "en" ..
            context.setLocale(const Locale('en'));
          }
        },
        icon: const Icon(Icons.translate));
  }

  // (2) (navigation)
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(BuildContext context) {
    Navigator.canPop(context);
  }

  static void pushAndReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pushAndRemove(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}

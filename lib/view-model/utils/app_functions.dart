import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppFunctions {
  // (translationIcon)

  static translationIcon(BuildContext context) {
    return
    IconButton(
        onPressed: () {
          // print(context.setLocale.toString());
          if (context.locale.toString() == 'en') {
            context.setLocale(Locale('ar'));
          }else {
            context.setLocale(Locale('en'));
          }
        },
        icon: Icon(Icons.translate));
  }


 // (navigation)
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
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

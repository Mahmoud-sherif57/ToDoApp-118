import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:ToDoApp/view-model/data/local/shared_keys.dart';
import 'package:ToDoApp/view-model/utils/app_assets.dart';
import 'package:ToDoApp/view-model/utils/app_functions.dart';
import 'package:ToDoApp/view/screens/home/home_screen.dart';
import 'package:ToDoApp/view/screens/auth_screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _visible = true;
      });
    });
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        const storage = FlutterSecureStorage(); // we called the secure storage to see if we have (token) skip loginScreen and go to HomeScreen
        String? value = await storage.read(key: SharedKeys.token);
        if (value != null) { // if storage couldn't find (token) => (value=null) this condition will be skipped..
          AppFunctions.pushAndRemove(context, const HomeScreen());
        } else {
          AppFunctions.pushAndRemove(context, const LoginScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: _visible ? 1 : 0,
        // child: Center(
        //   child: Image.asset(
        //     AppAssets.splashLogo,
        //     width: 400.w,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Center(child: Lottie.asset(AppAssets.loadingBuples),)
      ),
    );
  }
}



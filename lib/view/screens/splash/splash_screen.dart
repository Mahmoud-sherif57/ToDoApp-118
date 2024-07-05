import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view-model/utils/app_assets.dart';
import 'package:to_do_app/view-model/utils/app_functions.dart';
import 'package:to_do_app/view/screens/home/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  void initState () {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400),(){
      setState(() {
        _visible= true;
      });
    });
    Future.delayed(const Duration(seconds: 4),() {
      AppFunctions.pushAndRemove(context,const HomeScreen());
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: _visible ? 1:0,

        child: Center(
          child: Image.asset(AppAssets.splashLogo,width: 400.w,fit: BoxFit.cover ,),
        ),
      ),


    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';

ThemeData darkTheme =ThemeData(

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.gray
  ),
  scaffoldBackgroundColor: AppColors.black,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 20.sp,
      color:AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 25.sp,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 30.sp,
      color:AppColors.white,
    ),
  ),


);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: AppColors.purple),
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 20.sp,
      color:AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 25.sp,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 30.sp,
      color:AppColors.black,
    ),
  ),
);

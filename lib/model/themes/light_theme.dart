import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: AppColors.purple),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(10.sp),
    border: const OutlineInputBorder(),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.purple,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
    ),
  ),
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
  ),
);

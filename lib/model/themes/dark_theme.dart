import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';

ThemeData darkTheme = ThemeData(

  appBarTheme: const AppBarTheme(backgroundColor: AppColors.black38),


  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(10.sp),
    border: const OutlineInputBorder(),
    labelStyle: TextStyle(color: AppColors.gray ),

    iconColor: AppColors.gray,
  ),

  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.purple,
    textTheme: ButtonTextTheme.primary,
  ),

  iconTheme: IconThemeData(color: AppColors.gray ),


  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(AppColors.gray),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
    ),
  ),


  scaffoldBackgroundColor: AppColors.black,

  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: AppColors.gray,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      color: AppColors.gray,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      color: AppColors.gray,
    ),

    titleLarge: TextStyle(
      fontSize:25.sp,
      color: AppColors.white,
    ),
      titleMedium: TextStyle(
      fontSize:20.sp,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontSize:16.sp,
      color: AppColors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.gray,
    ),
    labelMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.gray,
    ),
    labelLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.gray,
    ),
  ),




);


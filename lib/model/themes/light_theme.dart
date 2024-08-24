import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';

ThemeData lightTheme = ThemeData(

  appBarTheme: const AppBarTheme(backgroundColor: AppColors.warmWhite),

  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(10.sp),
    border: const OutlineInputBorder(),
    labelStyle: TextStyle(color: AppColors.black38 ),
    iconColor: AppColors.black,


  ),


  buttonTheme: const ButtonThemeData(
    buttonColor: AppColors.purple,
    textTheme: ButtonTextTheme.primary,
  ),

  iconTheme: IconThemeData(color: AppColors.black),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(AppColors.black),
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



  scaffoldBackgroundColor: AppColors.warmWhite,


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
    titleLarge: TextStyle(
      fontSize:25.sp,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontSize:20.sp,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
      fontSize:16.sp,
      color: AppColors.black,
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

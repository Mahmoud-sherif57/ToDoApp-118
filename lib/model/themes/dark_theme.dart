import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.gray),

  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(10.sp),
    border: const OutlineInputBorder(),
  ),

  buttonTheme: const ButtonThemeData(
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


  // iconTheme: IconThemeData(color: AppColors.gray),
  // iconButtonTheme: IconButtonThemeData(
  //   style: ButtonStyle(
  //     iconColor: WidgetStatePropertyAll(AppColors.gray),
  //   ),
  // ),
  scaffoldBackgroundColor: AppColors.black38,
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
      color: AppColors.black,
    ),
  ),
);

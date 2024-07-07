import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/model/cubits/task/task_cubit.dart';
import 'package:to_do_app/model/cubits/theme/theme_cubit.dart';
import 'package:to_do_app/view/screens/splash/splash_screen.dart';
import 'model/cubits/theme/theme_state.dart';
import 'model/themes/dark_theme.dart';
import 'model/themes/light_theme.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ThemeCubit(),
              ),
              BlocProvider(
                create: (context) => TaskCubit(),
              ),
            ],
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'ToDoApp',
                  // localization
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  // themeMode
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: ThemeCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,

                  home: child,
                );
              },
            ),
          );
        },
        child: const SplashScreen());
  }
}

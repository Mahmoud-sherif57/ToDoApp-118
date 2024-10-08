import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ToDoApp/model/cubits/auth/auth_cubit.dart';
import 'package:ToDoApp/model/cubits/auth/auth_state.dart';
import 'package:ToDoApp/view-model/utils/app_assets.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';
import 'package:ToDoApp/view-model/utils/app_functions.dart';
import 'package:ToDoApp/view-model/localization/local_keys.g.dart';
import 'package:ToDoApp/view/screens/auth_screens/register.dart';
import '../home/home_screen.dart';

var hidden = true;
var unHiddenIcon = const Icon(Icons.visibility);
var hiddenIcon = const Icon(Icons.visibility_off);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context); // just to minimize the code ..

    return Scaffold(
        appBar: AppBar(
          leading: AppFunctions.translationIcon(context),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(12.w),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.logIn.tr(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        LocaleKeys.enterYourPassword.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: 25.h),
                      // making the email field
                      TextFormField(
                        controller: authCubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.email.tr(),
                          labelStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      // making the password field
                      // we used BlocBuilder here to handle toggling the password..
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) {
                          return current is TogglePasswordState;
                        },
                        builder: (context, state) {
                          // making the password field  (wrapped with BlocBuilder )
                          return TextFormField(
                            controller: authCubit.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 15,
                            textInputAction: TextInputAction.done,
                            obscureText: hidden,
                            // in line (15) we created this var
                            decoration: InputDecoration(
                              // helperText: LocaleKeys.forgetPassword.tr(),
                              labelText: LocaleKeys.password.tr(),
                              labelStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authCubit.togglePassword();
                                  },
                                  icon: hidden ? hiddenIcon : unHiddenIcon),
                            ),
                          );
                        },
                      ),

                      TextButton(
                        onPressed: () {
                          /// make a page to reset the password and navigate to this screen
                        },
                        child: Text(
                          LocaleKeys.forgetPassword.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.purple),
                        ),
                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                      // we used BlocConsumer here because we need BlocBuilder& BlocListener and the BlocConsumer have them both .
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is LoggingSuccessfulState) {
                            AppFunctions.pushAndRemove(
                                context, const HomeScreen());
                          } else if (state is LoggingErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: AppColors.purple,
                              ),
                            );
                          }
                        },
                        buildWhen: (previous, current) {
                          return current is LoggingLoadingState ||
                              current is LoggingSuccessfulState ||
                              current is LoggingErrorState;
                        },
                        builder: (context, state) {
                          if (state is LoggingLoadingState) {
                            return Center(
                              child: Lottie.asset(AppAssets.loadingBuples,
                                  width: 200.w, height: 150.h),
                              // CircularProgressIndicator(
                              //   color: AppColors.purple,
                              // ),
                            );
                          } else {
                            // creating the logIn button
                            return Center(
                              child: InkWell(
                                onTap: () {
                                  // if (state is LoggingLoadingState) return;
                                  // the button will be unClickable as long as the state is loading .

                                  // here we called the login method (authCubit)
                                  authCubit.login();
                                },

                                // start creating (LogIn ButtonIcon )
                                child: Container(
                                  width: 364.w,
                                  height: 67.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19.r),
                                    color: AppColors.purple,
                                  ),
                                  child: Center(
                                    child: Text(LocaleKeys.logIn.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  // end of creating (LogIn ButtonIcon )

                  // creating the last line after logIn button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.doNotHaveAnAccount.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      TextButton(
                        child: Text(
                          LocaleKeys.signUp.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.registerColor),
                        ),
                        onPressed: () {
                          AppFunctions.push(context, const RegisterScreen());
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

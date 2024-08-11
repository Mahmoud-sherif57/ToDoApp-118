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
import 'package:ToDoApp/view/screens/home/home_screen.dart';

var hidden = true;
var unHiddenIcon = const Icon(Icons.visibility);
var hiddenIcon = const Icon(Icons.visibility_off);

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit.get(context); // just to minimize the code ..
    // we created BlocProvider here not in (main/ multiBlocProvider/) because i'll use it once in the loginScreen
    // and will destroy, but in (main) will be exist forever

    return Scaffold(
        appBar: AppBar(
          actions: [AppFunctions.translationIcon(context)],
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
                        LocaleKeys.register.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25.sp),
                      ),

                      SizedBox(height: 25.h),
                      // making the name field
                      TextFormField(
                        controller: authCubit.nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.userName.tr(),
                          labelStyle:
                              const TextStyle(color: AppColors.darkGray),
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      // making the email field
                      TextFormField(
                        controller: authCubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: LocaleKeys.email.tr(),
                          labelStyle:
                              const TextStyle(color: AppColors.darkGray),
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      // making the password field
                      // we used BlocBuilder here to handle the hidden & unhiddenIcon
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
                              labelText: LocaleKeys.password.tr(),
                              labelStyle:
                                  const TextStyle(color: AppColors.darkGray),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authCubit.togglePassword();
                                  },
                                  icon: hidden ? hiddenIcon : unHiddenIcon),
                            ),
                          );
                        },
                      ),

                      // making the confirm password field ..
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen: (previous, current) {
                          return current is TogglePasswordState;
                        },
                        builder: (context, state) {
                          // making the password field  (wrapped with BlocBuilder )
                          return TextFormField(
                            controller: authCubit.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 15,
                            textInputAction: TextInputAction.done,
                            obscureText: hidden,
                            // in line (15) we created this var
                            decoration: InputDecoration(
                              labelText: LocaleKeys.confirmPassword.tr(),
                              labelStyle:
                                  const TextStyle(color: AppColors.darkGray),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    authCubit.togglePassword();
                                  },
                                  icon: hidden ? hiddenIcon : unHiddenIcon),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                      // we used BlocConsumer here because we need BlocBuilder& BlocListener  and the BlocConsumer have them both .
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            AppFunctions.push(context, const HomeScreen());
                          } else if (state is RegisterErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: AppColors.red,
                              ),
                            );
                          }
                        },
                        buildWhen: (previous, current) {
                          return current is RegisterLoadingState ||
                              current is RegisterSuccessState ||
                              current is RegisterErrorState;
                        },
                        builder: (context, state) {
                          return Visibility(
                            visible: state
                                is RegisterLoadingState, // the child of visible is lotti animation in below ..
                            replacement: Center(
                              child: InkWell(
                                onTap: () {
                                  // if (state is RegisterLoadingState) return;
                                  // the button will be unClickable as long as the state is loading .

                                  // here we called the register method (authCubit)
                                  authCubit.registerFireBase();
                                },

                                // start creating (register ButtonIcon )
                                child: Container(
                                  width: 364.w,
                                  height: 67.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19.r),
                                    color: AppColors.purple,
                                  ),
                                  child: Center(
                                    child: Text(
                                      LocaleKeys.register.tr(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Lottie.asset(AppAssets.loadingBuples,
                                  width: 200.w, height: 150.h),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  // end of creating (LogIn ButtonIcon )
                ],
              ),
            ),
          ),
        ));
  }
}

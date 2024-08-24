import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ToDoApp/view-model/data/local/shared_keys.dart';
import 'package:ToDoApp/view-model/data/network/dio_helper.dart';
import 'package:ToDoApp/view-model/data/network/end_points.dart';
import 'package:ToDoApp/view/screens/auth_screens/login.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  // making a controllers to catch what the user write in the textFormField .,

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // (CREATING OUR FUNCTIONS)
  //1st method to show and hidden the password
  // start (togglePassword Function) .

  void togglePassword() {
    hidden = !hidden;
    emit(TogglePasswordState());
  }
  // end of (togglePassword Function) .

  // start clearing controllers
  void clearControllers (){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
  // end of clearing controllers

  //2d method to handle actions when i call the (logIn Function) with API.
  // start (logIn Function)
  Future<void> login() async {
    // we used (async & await) cause we don't know how long it takes to get the response .
    emit(LoggingLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.logIn,
      body: {
        "email": emailController.text,
        // Access the email text value of the controller
        "password": passwordController.text,
        // Access the password text value of the controller
      },
    ).then(
      // (then) it means we have successful logging then print the value.data which means response.data & send emit success State .
      (value) async {
        const storage =
            FlutterSecureStorage(); //to encrypt the token... we need to save the value so use (storage.write)
        //(key=> the thing i need to encrypt)..(value=> where is the that thing)
        debugPrint(value.data?.toString() ?? '');
        await storage.write(
            key: SharedKeys.token, value: value.data['data']['token']);
        debugPrint(value.data?.toString() ?? "");
        emit(LoggingSuccessfulState());
      },
    ).catchError((error) {
      debugPrint(error.toString());
      //(catchError) it means we have error with logging, so print the error and emit error State .
      if (error is DioException) {
        debugPrint(error.response?.data?.toString() ?? 'hi hi');
        emit(LoggingErrorState(
            error.response?.data['message'] ?? 'something went wrong 1'));
        return; // we used (return ;) here to ignore any lines below  if we entered this (if condition) .
      }
      debugPrint(error.toString());
      emit(LoggingErrorState(
          'something went wrong with logging ${error.toString()}'));
      throw error;
      // if it's not DioException emit this message and error .
      // may be we have a network problem OR we sent to wrong endPoint(not DioException) so we will be stuck in loadingState if we didn't make this emit .
    });
  }
  // end of (logIn Function)

  // start loginFirebase function
  // Future<void> loginFirebase() async {
  //   emit(LoggingLoadingState());
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     print(value.user?.uid);
  //     print(value.user?.email);
  //     print(value.user?.emailVerified);
  //     emit(LoggingSuccessfulState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(LoggingErrorState(
  //         "something went wrong on login with firebase ${error.toString()}"));
  //   });
  // }
  //  end of loginFirebase function

  // (CREATING OUR REGISTER FUNCTION) .
  // start (register Function)
  Future<void> register() async {
    emit(RegisterLoadingState());
    await DioHelper.post(
      endPoint: EndPoints.register,
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      },
    ).then(
      (value) async {
        // debugPrint(value.data ?? "Register Successfully");
        const storage = FlutterSecureStorage();
        await storage.write(
            key: SharedKeys.token, value: value.data['data']['token']);
        emit(RegisterSuccessState());
      },
    ).catchError((error) {
      if (error is DioException) {
        debugPrint(error.response?.data.toString());
        emit(RegisterErrorState(
            error.response?.data['message'] ?? 'something went wrong 1'));
        return;
      }
      // debugPrint(error.response?.data?.toString());
      emit(RegisterErrorState(
          'something went wrong with logging ${error.toString()}'));
      throw (error);
    });
  } // end of (register Function)

  // (CREATING OUR REGISTER WITH FIREBASE FUNCTION) 1/8/2024
  // Future<void> registerFireBase() async {
  //   emit(RegisterLoadingState());
  //   await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     emit(RegisterSuccessState());
  //     print(value.user?.uid);
  //     print(value.user?.email);
  //     print(value.user?.emailVerified);
  //   }).catchError((error) {
  //     emit(RegisterErrorState(
  //         "something went wrong on login firebase => ${error.toString()}"));
  //     print(error.to string());
  //     throw error;
  //   });
  // }
}

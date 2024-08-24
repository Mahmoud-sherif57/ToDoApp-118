import 'package:ToDoApp/model/cubits/auth/auth_cubit.dart';
import 'package:ToDoApp/view-model/data/network/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ToDoApp/model/cubits/task/task_cubit.dart';
import 'package:ToDoApp/model/cubits/theme/theme_cubit.dart';
import 'package:ToDoApp/view-model/utils/app_assets.dart';
import 'package:ToDoApp/view-model/utils/app_functions.dart';
import 'package:ToDoApp/view-model/localization/local_keys.g.dart';
import 'package:ToDoApp/view/screens/home/add_task_widget.dart';
import 'package:ToDoApp/view/screens/home/task_widget.dart';
import 'package:ToDoApp/view/screens/auth_screens/login.dart';
import '../../../model/cubits/task/task_state.dart';
import '../../../model/cubits/theme/theme_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: TaskCubit.get(context)
        ..getAllTasks()
        ..initScrollController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.toDoApp.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          leading: AppFunctions.translationIcon(context),
          centerTitle: true,
          actions: [
            //   IconButton(onPressed: (){
            //   AppFunctions.push(context, const PokemonScreen());
            // }, icon: const Icon(Icons.catching_pokemon)),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return AnimatedRotation(
                  turns: ThemeCubit.get(context).isDark ? 0 : 1,
                  duration: const Duration(milliseconds: 800),
                  child: IconButton(
                      onPressed: () {
                        ThemeCubit.get(context).changeThemeMode();
                      },
                      icon: Icon(
                        ThemeCubit.get(context).isDark
                            ? Icons.sunny
                            : Icons.nightlight_round_rounded,
                        // color: AppColors.black,
                      )),
                );
              },
            ),
            const SizedBox(),
            IconButton(
              onPressed: () async {
               await DioHelper.storage.deleteAll(); // to delete the token ..
               AuthCubit.get(context).clearControllers(); // to remove the email and password from the controller
               AppFunctions.pushAndRemove(context, LoginScreen());

              },
              icon: const Icon(
                Icons.logout,
                // color: AppColors.black,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isDismissible: false,
              isScrollControlled: true,
              showDragHandle: true,
              context: context,
              builder: (context) {
                return const AddTaskWidget();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is UnauthenticatedState) {
              // if the token is expired or deleted from the cash..
              AppFunctions.pushAndRemove(context, const LoginScreen());
            }
          },
          builder: (context, state) {
            if (state is GetAllTasksLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UnauthenticatedState) {
              AppFunctions.pushAndRemove(context, const LoginScreen());
            }
            return Column(
              children: [
                // we added Task widget to show us how many task we have till now
                Text(
                  '${TaskCubit.get(context).tasksList.length}  ${LocaleKeys.tasks.tr()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                Expanded(
                  child: Visibility(
                    visible: TaskCubit.get(context).tasksList.isNotEmpty,
                    replacement: Lottie.asset(AppAssets.emptyTasks),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await TaskCubit.get(context).getAllTasks();
                      },
                      child: BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
                          return ListView.separated(
                            controller: TaskCubit.get(context).controller,
                            itemBuilder: (context, index) => TaskWidget(
                              onDeleteIconPressed: () {
                                TaskCubit.get(context).deleteTaskFromAPI(index);
                              },
                              task: TaskCubit.get(context).tasksList[index],
                            ),
                            itemCount: TaskCubit.get(context).tasksList.length,
                            separatorBuilder: (context, index) => SizedBox(
                              height: 12.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/model/cubits/task/task_cubit.dart';
import 'package:to_do_app/model/cubits/theme/theme_cubit.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';
import 'package:to_do_app/view-model/utils/app_functions.dart';
import 'package:to_do_app/view-model/utils/local_keys.g.dart';
import 'package:to_do_app/view/screens/home/add_task_widget.dart';
import 'package:to_do_app/view/screens/home/task_widget.dart';
import '../../../model/cubits/task/task_state.dart';
import '../../../model/cubits/theme/theme_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.toDoApp.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: AppFunctions.translationIcon(context),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    ThemeCubit.get(context).changeThemeMode();
                  },
                  icon: Icon(
                    ThemeCubit.get(context).isDark
                        ? Icons.sunny
                        : Icons.nightlight_round_rounded,
                    color: AppColors.black,
                  ));
            },
          ),
          const SizedBox(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: AppColors.black,
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
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return Column(
            children: [
              // we added Task widget to show us how many task we have till now
              Text(
                '${TaskCubit.get(context).tasks.length}  ${LocaleKeys.tasks.tr()}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => TaskWidget(
                    onDeleteIconPressed: () {
                      TaskCubit.get(context).deleteTask(index);
                    },
                    task: TaskCubit.get(context).tasks[index],
                  ),
                  itemCount: TaskCubit.get(context).tasks.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

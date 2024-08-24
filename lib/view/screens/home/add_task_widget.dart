
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/model/cubits/task/task_cubit.dart';
import 'package:ToDoApp/model/cubits/task/task_state.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';
import 'package:ToDoApp/view-model/localization/local_keys.g.dart';
import 'package:ToDoApp/view-model/utils/click_widget.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: TaskCubit.get(context).formState,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            // top: 12.h,
            left: 12.w,
            right: 12.w,
            // to allow the
            bottom: MediaQuery.of(context).viewInsets.bottom),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.addTask.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.black38),
                ),
              ),
              IconButton(
                  onPressed: ()async {
                    TaskCubit.get(context).clearControllers();
                    Navigator.pop(context);
                    // final player =AudioPlayer();
                    // await player.play(UrlSource(AppAssets.audio));

                  },

                  icon: const Icon(Icons.close_rounded))
            ],
          ),
          SizedBox(
            height: 12.h,
          ),

          // title text form field
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: TaskCubit.get(context).titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: LocaleKeys.title.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.thisFieldsIsRequired.tr();
              }
              return null;
            },
          ),
          SizedBox(height: 12.sp),

          // description text form field
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: TaskCubit.get(context).descriptionController,
            decoration: InputDecoration(
              labelText: LocaleKeys.description.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.thisFieldsIsRequired.tr();
              }
              return null;
            },
          ),
          SizedBox(height: 12.sp),

          // start of (start date) text form field
          TextFormField(
            controller: TaskCubit.get(context).startDateController,
            keyboardType: TextInputType.none,
            textInputAction: TextInputAction.next,
            readOnly: true,
            decoration: InputDecoration(
              labelText: LocaleKeys.startDate.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.thisFieldsIsRequired.tr();
              }
              return null;
            },
            onTap: () {
              showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              ).then(
                (value) {
                  if (value != null) {
                    TaskCubit.get(context).startDateController.text =
                        DateFormat('yyyy-MM-dd').format(value);
                  }
                },
              );
            },
          ),
          SizedBox(height: 12.sp),
          // end of (start date) text form field

          // start of (end date) text form field
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: TaskCubit.get(context).endDateController,
            keyboardType: TextInputType.none,
            readOnly: true,
            decoration: InputDecoration(
              labelText: LocaleKeys.endDate.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return LocaleKeys.thisFieldsIsRequired.tr();
              }
              return null;
            },
            onTap: () {
              showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
                initialEntryMode: DatePickerEntryMode.calendarOnly,
              ).then((value) {
                if (value != null) {
                  TaskCubit.get(context).endDateController.text =
                      DateFormat('yyyy-MM-dd').format(value);
                }
              });
            },
          ),
          // end of (end date) text form field
          SizedBox(
            height: 15.h,
          ),
          // start the image field ..
          ClickWidget(
            onTap: () async {
              TaskCubit.get(context).pickImageFromGallery();
            },
            withBorder: true,
            child: Visibility(
              visible: TaskCubit.get(context).MyImage == null,
              replacement:
                  Image.file(File(TaskCubit.get(context).MyImage?.path ?? "")),
              child: BlocBuilder<TaskCubit, TaskState>(
                buildWhen: (previous, current) {
                  return current is PickImageState;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Icon(Icons.image,color: AppColors.black38),
                      SizedBox(
                        height: 6.h,
                      ),
                      const Text(LocaleKeys.uploadImage).tr(),
                    ],
                  );
                },
              ),
            ),
          ),
          // end of the image field ..

          SizedBox(height: 20.sp),

          // start the (submit) button ..
          ElevatedButton(
            onPressed: () {
              if (TaskCubit.get(context).formState.currentState!.validate()) {
                TaskCubit.get(context).addTaskToAPI().then(
                  (value) {
                    TaskCubit.get(context).clearControllers();

                    Navigator.pop(context);
                    // AppFunctions.pop(context);
                  },
                );
              }
            },
            child: Text(
              LocaleKeys.submit.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.white),
            ),
          ),
          // end of the (submit) button

          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}

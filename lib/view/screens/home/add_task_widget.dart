import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/model/cubits/task/task_cubit.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';
import 'package:to_do_app/view-model/utils/app_functions.dart';
import 'package:to_do_app/view-model/utils/local_keys.g.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: TaskCubit.get(context).formState,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            top: 12.h,
            left: 12.w,
            right: 12.w,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        children: [
          Text(
            LocaleKeys.addTask.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
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
          // //  image form field
          // TextFormField(
          //   textInputAction: TextInputAction.next,
          //   controller: TaskCubit.get(context).imageController,
          //   decoration: InputDecoration(
          //     labelText: LocaleKeys.image.tr(),
          //   ),
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return LocaleKeys.thisFieldsIsRequired.tr();
          //     }
          //     return null;
          //   },
          // ),
          // SizedBox(height: 12.sp),

          // start date text form field
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: TaskCubit.get(context).startDateController,
            keyboardType: TextInputType.none,
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
                        DateFormat.yMMMMEEEEd().format(value);
                  }
                },
              );
            },
          ),
          SizedBox(height: 12.sp),

          // end date text form field
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
                      DateFormat.yMMMMEEEEd().format(value);
                }
              });
            },
          ),
          SizedBox(height: 20.sp),
          ElevatedButton(
            onPressed: () {
              if (TaskCubit.get(context).formState.currentState!.validate()) {
                TaskCubit.get(context).addTask();
                AppFunctions.pop(context);
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
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}

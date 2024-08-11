import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/model/task_model.dart';
import 'package:ToDoApp/view-model/utils/app_functions.dart';
import 'package:ToDoApp/view-model/localization/local_keys.g.dart';
import '../../../view-model/utils/app_colors.dart';
import 'date_info_widget.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final void Function()? onDeleteIconPressed;

  const TaskWidget(
      {required this.task, required this.onDeleteIconPressed, super.key});

  get index => null;

  @override
  Widget build(BuildContext context) {
    // to edit the form field
    // final TextEditingController editController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.purple, width: 2.w),
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title ?? "NO Title Found",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  // first line to delete the task ..
                  PopupMenuItem(
                    child: ListTile(
                      onTap: onDeleteIconPressed,
                      title: const Text(LocaleKeys.delete).tr(),
                      leading: const Icon(
                        Icons.delete,
                        color: AppColors.red,
                      ),
                    ),
                  ),

                  // second line to edit the task ..
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text(LocaleKeys.edit).tr(),
                      leading: const Icon(
                        Icons.edit,
                        color: AppColors.red,
                      ),
                      onTap: () {
                        showDialog(
                          // dialog to edit the task ..
                          context: context,
                          builder: (context) {
                            final titleController =
                                TextEditingController(text: task.title);
                            final descriptionController =
                                TextEditingController(text: task.description);
                            return AlertDialog(
                              title: const Text(LocaleKeys.editTask).tr(),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    // first field to edit the title ..
                                    controller: titleController,
                                    decoration: InputDecoration(
                                        labelText: LocaleKeys.title.tr()),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  TextField(
                                    //second field to edit the description ..
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                        labelText: LocaleKeys.description.tr()),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  // this button to save the changes in editing field ..
                                  onPressed: () {
                                    // if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                                    // TaskCubit.get(context).updateTask(
                                    // task.
                                    // copyWith(
                                    // title: titleController.text,
                                    // description: descriptionController.text,
                                    // ),
                                    // );
                                    AppFunctions.pop(context);
                                    // }
                                  },
                                  child: Text(LocaleKeys.save.tr()),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            task.description ?? "No Subtitle Found",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.gray),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (task.image != null ||
              (task.image ?? '')
                  .isNotEmpty) //if the condition is false the image will not build
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(12.r),
            //   child: Image.asset(
            //     AppAssets.warrior,
            //     width: double.infinity,
            //     height: 200.h,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(height: 10.h),
          IntrinsicHeight(
            // to make the two date container be at the same high
            child: Row(
              children: [
                Expanded(
                  child: InfoWidget(
                      icon: Icons.alarm,
                      text: task.startDate ?? "No StartDate "),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                  child: InfoWidget(
                      icon: Icons.alarm_off_outlined,
                      text: task.endDate ?? "No EndDate"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

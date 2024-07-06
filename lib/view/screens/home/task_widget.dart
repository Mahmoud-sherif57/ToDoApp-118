import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/model/task_model.dart';
import '../../../view-model/utils/app_colors.dart';
import 'date_info_widget.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final void Function()? onDeleteIconPressed;

  const TaskWidget(
      {required this.task, required this.onDeleteIconPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
          color: AppColors.babyblue,
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
              IconButton(
                onPressed: onDeleteIconPressed,
                icon: Icon(Icons.delete),
                color: AppColors.red,
              ),
            ],
          ),
          Text(
            task.description ?? "No Subtilte Found",
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
            //     AppAssets.warior,
            //     width: double.infinity,
            //     height: 200.h,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(height: 10.h),
          IntrinsicHeight(
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

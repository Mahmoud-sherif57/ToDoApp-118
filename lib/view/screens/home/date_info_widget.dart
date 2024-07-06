import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view-model/utils/app_colors.dart';

// here we custom the container that have icon & date and give it final icon and text //
// so whenever we call the container we just give it the text and the icon

class InfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          color: AppColors.babyblue,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.purple, width: 2.w)),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 15.w),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodySmall,)),
        ],
      ),
    );
  }
}

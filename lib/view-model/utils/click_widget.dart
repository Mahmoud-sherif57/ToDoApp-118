import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// here we custom ClickWidget to use it enyWhere in the project..  session (17)..
class ClickWidget extends StatelessWidget {
  final Color? color;
  final double? radius;
  final Color? shadowColor;
  final double? elevation;
  final void Function()? onTap;
  final Widget? child;
  final bool withBorder;

  const ClickWidget({
    required this.child,
    this.color,
    this.radius = 12,
    this.shadowColor,
    this.elevation = 0,
    this.onTap,
    this.withBorder =false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(radius!),
      shadowColor: shadowColor,
      elevation: elevation!,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius!),
        child: Container(
           padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
              border: withBorder? Border.all() : null,
            ),

            child: child),
      ),
    );
  }
}

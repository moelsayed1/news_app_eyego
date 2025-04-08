import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_eyego/Core/theming/styles.dart';

Widget googleSignInButton({
  required String text,
  dynamic icon,
  required Color color,
  Color? borderColor,
  Color textColor = Colors.white,
  required VoidCallback onTap,
  bool isIconAsset = true,
  Gradient? gradient,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(15.r),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isIconAsset)
                  Image.asset(
                    icon,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.contain,
                  )
                else
                  Icon(icon, size: 24.sp, color: textColor),
                SizedBox(width: 12.w),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      text,
                      style: TextStyles.signInButtonStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

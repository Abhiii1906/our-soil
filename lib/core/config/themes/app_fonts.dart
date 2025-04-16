import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_color.dart';

class AppFonts {
  AppFonts._();

  static const String fontFamily = 'Montserrat';

  static final TextStyle headline = TextStyle(
      fontSize: 22.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: AppColor.white);

  static final TextStyle title = TextStyle(
      fontSize: 20.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      color: AppColor.white);

  static final TextStyle subtitle = TextStyle(
      fontSize: 18.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w500,
      color: AppColor.white);

  static final TextStyle body = TextStyle(
      fontSize: 14.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: AppColor.white);

  static final TextStyle caption = TextStyle(
      fontSize: 12.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: AppColor.white);

  static final TextStyle small = TextStyle(
      fontSize: 10.sp,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
      color: AppColor.white);
}

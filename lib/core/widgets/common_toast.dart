import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/themes/app_color.dart';

enum Status{
   success,
   failed
}
showNotification(BuildContext context, { required String message, String title= 'Message',Status ? status}) {
  Flushbar(
    title: title,
    message: message,
    duration: const Duration(seconds: 5),
    flushbarPosition: FlushbarPosition.TOP,
    margin:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
    borderRadius: BorderRadius.circular(8),
    backgroundColor:status ==Status.success?AppColor.success:AppColor.warning,// AppColor.flushColor,
    blockBackgroundInteraction: false,
    routeColor:status ==Status.success?AppColor.success:AppColor.warning,
  ).show(context);
}
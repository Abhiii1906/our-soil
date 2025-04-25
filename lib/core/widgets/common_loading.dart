import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../config/resource/images.dart';
import '../utils/logger.dart';

bool isShowLoading = false;
showLoading(BuildContext context, {dissmissable = true, String text = 'Loading'}) {
  if (!isShowLoading) {
    //LoadingScreen is not shown
    isShowLoading = true;
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: dissmissable,
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: Container(
              color:Colors.black.withOpacity(0.34),
              child: Center(
                child:
                Container(
                    padding: EdgeInsets.symmetric(horizontal:10.w! ,vertical: 10.h!),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      // borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CircularProgressIndicator(),
                    // child: SizedBox(
                    //   width: 100.w,
                    //   height: 100.h,
                    //   child:  Lottie.asset(Images.),
                    // )
                ),
              ),
            ),
          );
        });
  }
}

hideLoading(BuildContext context) {
  isShowLoading = false;
  var route = ModalRoute.of(context)?.settings.name;
  if (route != null) {
    debugLog("hideLoading: $route");
  }
  Navigator.of(context, rootNavigator: false).pop();
}
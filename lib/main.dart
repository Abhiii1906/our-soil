import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/config/route/app_route.dart';
import 'core/storage/secure_storage.dart';

void main() {
  Preference();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Use Size instead of DesignSize
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'E-SHOP',
          theme: ThemeData(
            primarySwatch: Colors.green,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.transparent,
            ),
          ),
          onGenerateRoute: AppRoute().onGenerateRoute,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


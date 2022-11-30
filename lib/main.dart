import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sysqbit_todo/config/router/app_routes.dart';

import 'config/styles/theme/app_theme.dart';

void main() {
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      // enabled: false,
      builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Sysqbit Todo',
        theme: AppTheme.fromType(ThemeType.light).themeData,
        initialRoute: AppRouter.themePage,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

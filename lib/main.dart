import 'package:expirdate/services/hive_services.dart';
import 'package:expirdate/utils/app_colors.dart';
import 'package:expirdate/utils/text/app_text_styles.dart';
import 'package:expirdate/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.initHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expiry Date Detection',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleLarge: AppTextStyles.headline1,
          titleMedium: AppTextStyles.headline2,
          titleSmall: AppTextStyles.headline3,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
        ),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          titleTextStyle: AppTextStyles.headline2,
        ),
      ),
      home: SplashScreen(),
    );
  }
}



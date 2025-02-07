import 'dart:async';
import 'package:expirdate/constants/app_assets.dart';
import 'package:expirdate/utils/app_colors.dart';
import 'package:expirdate/utils/text/app_text_styles.dart';
import 'package:expirdate/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(Duration(milliseconds: 3000), () {
      Get.off(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.appLogo,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Expiry Date Detection",
              style:
                  AppTextStyles.headline2.copyWith(color: AppColors.textWhite),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              color: AppColors.textWhite,
            ),
          ],
        ),
      ),
    );
  }
}

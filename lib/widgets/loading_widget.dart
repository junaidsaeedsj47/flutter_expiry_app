import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  LoadingWidget({this.message = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: AppColors.primary),
        SizedBox(height: 10),
        Text(
          message,
          style: TextStyle(color: AppColors.primary, fontSize: 16),
        ),
      ],
    );
  }
}
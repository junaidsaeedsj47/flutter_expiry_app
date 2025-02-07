import 'package:expirdate/utils/app_colors.dart';
import 'package:expirdate/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppUtil {
  static DateTime? parseDate(String dateStr) {
    try {
      dateStr =
          dateStr.replaceAll(RegExp(r'[/.]'), '-');

      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateStr)) {
        return DateTime.parse(dateStr); // YYYY-MM-DD
      } else if (RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(dateStr)) {
        return DateFormat("dd-MM-yyyy").parse(dateStr); // DD-MM-YYYY
      }
    } catch (e) {
      print("Date Parsing Error: $e");
    }
    return null;
  }

  static String getExpiryStatus(DateTime expiryDate) {
    int daysRemaining = expiryDate.difference(DateTime.now()).inDays;
    if (daysRemaining > 7) return "🟢 Safe to consume";
    if (daysRemaining > 0) return "🟡 Approaching expiry";
    return "🔴 Expired";
  }

  static void showLoader() {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
        ),
      ),
      barrierDismissible: false,
    );
  }
  static void dismissLoader() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static String? getStatusText(ExpiryStatus? status) {
    if (status case ExpiryStatus.green) {
      return "🟢 Safe to Consume";
    } else if (status case ExpiryStatus.yellow) {
      return "🟡 Approaching Expiry";
    } else if (status case ExpiryStatus.red) {
      return "🔴 Expired";
    }
    return null;
  }

  static String? getStatusTextOnly(ExpiryStatus? status) {
    if (status case ExpiryStatus.green) {
      return "Safe to Consume";
    } else if (status case ExpiryStatus.yellow) {
      return "Approaching Expiry";
    } else if (status case ExpiryStatus.red) {
      return "Expired";
    }
    return null;
  }
  static Color? getStatusColor(ExpiryStatus? status) {
    if (status case ExpiryStatus.green) {
      return AppColors.safeGreen;
    } else if (status case ExpiryStatus.yellow) {
      return AppColors.warningYellow;
    } else if (status case ExpiryStatus.red) {
      return AppColors.dangerRed;
    }
    return AppColors.dangerRed;
  }
  static String? formatDate(DateTime? date) {
    return DateFormat("dd-MM-yyyy").format(date!);
  }

  static void showErrorDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

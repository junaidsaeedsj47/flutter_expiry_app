import 'package:expirdate/utils/enum.dart';
import 'package:hive/hive.dart';

part 'scanned_product_model.g.dart';


@HiveType(typeId: 0)
class ScannedProduct {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime expiryDate;

  ScannedProduct({required this.name, required this.expiryDate});

  ExpiryStatus? getStatus() {
    final today = DateTime.now();
    final difference = expiryDate.difference(today).inDays;

    if (difference > 7) return ExpiryStatus.green;
    if (difference > 0) return ExpiryStatus.yellow;
    return ExpiryStatus.red;
  }
  String getCountdownMessage() {
    final today = DateTime.now();
    final difference = expiryDate.difference(today).inDays;

    if (difference > 0) {
      return "$difference days left";
    } else if (difference == 0) {
      return "Expires today!";
    } else {
      return "Expired ${difference.abs()} days ago";
    }
  }
}

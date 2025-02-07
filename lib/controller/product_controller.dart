import 'dart:io';
import 'package:expirdate/models/scanned_product_model.dart';
import 'package:expirdate/services/barcode_scanning_services.dart';
import 'package:expirdate/services/hive_services.dart';
import 'package:expirdate/services/text_to_speech_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../services/ocr_service.dart';
import '../utils/app_util.dart';

class ProductController extends GetxController {
  var products = <ScannedProduct>[].obs;
  final OCRService ocrService = OCRService();
  final BarcodeService barcodeService = BarcodeService();
  final TextToSpeechService textToSpeechService = TextToSpeechService();

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    products.assignAll(HiveService.getProducts());
  }

  Future<void> addProduct(String name, DateTime expiryDate) async {
    ScannedProduct product = ScannedProduct(name: name, expiryDate: expiryDate);
    await HiveService.addProduct(product);
    products.add(product);
    products.refresh();
  }

  Future<void> deleteProduct(String name) async {
    await HiveService.deleteProduct(name);
    products.removeWhere((p) => p.name == name);
    products.refresh();
  }

  Future<void> pickImage(BuildContext context, {bool isBarcode = false}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );

      if (pickedFile != null) {
        File image = File(pickedFile.path);

        if (isBarcode) {
          Map<String, String?> barcodeResult =
              await barcodeService.scanBarcodeAndFetchDetails(image);

          if (barcodeResult.isNotEmpty &&
              barcodeResult["productName"] != null) {
            addProduct(barcodeResult["productName"] ?? "Scanned Product",
                DateTime.now());
          } else {
            AppUtil.showErrorDialog("Product Not Found",
                "The scanned product could not be identified.");
          }
        } else {
          Map<String, String?> result =
              await ocrService.extractProductDetails(image);
          String? productName = result["productName"] ?? "Scanned Product";
          String? expiryDateStr = result["expiryDate"];

          if (expiryDateStr != null) {
            DateTime? expiryDate = AppUtil.parseDate(expiryDateStr);
            if (expiryDate != null) {
              addProduct(productName, expiryDate);
            } else {
              AppUtil.showErrorDialog("Invalid Expiry Date",
                  "The extracted expiry date is not valid.");
            }
          } else {
            AppUtil.showErrorDialog("Expiry Date Not Found",
                "No expiry date detected. Please try again.");
          }
        }
      } else {
        AppUtil.showErrorDialog(
            "No Image Selected", "You need to take a picture to proceed.");
      }
    } catch (e) {
      debugPrint("❌ Error during image picking: $e");
      AppUtil.showErrorDialog("Error", "An error occurred: $e");
    } finally {
      products.refresh();
    }
  }

  speakText(String? text) {
    textToSpeechService.speakText(text);
  }
}

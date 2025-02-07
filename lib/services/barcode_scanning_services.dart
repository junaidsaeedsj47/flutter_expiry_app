import 'dart:io';

import 'package:expirdate/constants/url_constants.dart';
import 'package:expirdate/utils/app_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarcodeService {
  final barcodeScanner = BarcodeScanner();
  Future<Map<String, String?>> scanBarcodeAndFetchDetails(File image) async {
    AppUtil.showLoader();
    final inputImage = InputImage.fromFile(image);
    final barcodes = await barcodeScanner.processImage(inputImage);

    if (barcodes.isNotEmpty) {
      String barcode = barcodes.first.rawValue ?? "";

      if (barcode.isNotEmpty) {
        try {
          Map<String, String?> productDetails = await fetchProductDetails(barcode);
          AppUtil.dismissLoader();
          if (productDetails.isNotEmpty && productDetails["productName"] != "Unknown Product") {
            return {
              "barcode": barcode,
              "productName": productDetails["productName"],
              "brand": productDetails["brand"]
            };
          }
        } catch (e) {
          AppUtil.dismissLoader();
          debugPrint("❌ Error fetching product details: $e");
        }
      }
    }
    AppUtil.dismissLoader();
    return {};
  }

  Future<Map<String, String?>> fetchProductDetails(String barcode) async {
    final String url = AppUrls.getProductByBarcode(barcode);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey("product") && data["product"] != null) {
        return {
          "productName": data["product"]["product_name"] ?? "Unknown Product",
          "brand": data["product"]["brands"] ?? "Unknown Brand"
        };
      }
    }

    return {};
  }
}
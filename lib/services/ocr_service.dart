import 'dart:io';
import 'package:expirdate/services/ai_services.dart';
import 'package:expirdate/utils/app_util.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {
  final textRecognizer = TextRecognizer();
  final AIService aiService = AIService();

  Future<Map<String, String?>> extractProductDetails(File image) async {
    AppUtil.showLoader();
    final inputImage = InputImage.fromFile(image);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String extractedText = recognizedText.text;

    RegExp datePattern =
        RegExp(r'\b(\d{2}[-./]\d{2}[-./]\d{4}|\d{4}[-./]\d{2}[-./]\d{2})\b');
    Match? dateMatch = datePattern.firstMatch(extractedText);

    String? expiryDate;
    if (dateMatch != null) {
      expiryDate = dateMatch
          .group(0)!
          .replaceAll(RegExp(r'[/\.]'), '-'); // Normalize separators
    } else {
      expiryDate = await aiService.enhanceOCR(extractedText);
    }
    List<String> lines =
        extractedText.split('\n').map((e) => e.trim()).toList();
    String? productName;

    for (String line in lines) {
      if (!datePattern.hasMatch(line) && line.isNotEmpty) {
        productName = line;
        break;
      }
    }
    AppUtil.dismissLoader();
    return {
      "productName": productName,
      "expiryDate": expiryDate,
    };
  }
}

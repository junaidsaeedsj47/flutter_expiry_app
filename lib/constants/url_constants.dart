class AppUrls {
  static const String apiChatCompletions =
      "https://api.openai.com/v1/chat/completions";

  static String getProductByBarcode(String barcode) {
    return "https://world.openfoodfacts.org/api/v0/product/$barcode.json";
  }
}

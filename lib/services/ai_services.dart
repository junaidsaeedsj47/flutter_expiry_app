import 'dart:convert';
import 'package:expirdate/constants/url_constants.dart';
import 'package:http/http.dart' as http;

class AIService {
  Future<String> enhanceOCR(String text) async {
    final response = await http.post(
      Uri.parse(AppUrls.apiChatCompletions),
      headers: {
        "Authorization":
            "Bearer APIKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o",
        "messages": [
          {
            "role": "system",
            "content": "You are an AI that extracts expiry dates from text."
          },
          {
            "role": "user",
            "content": "Extract the expiry date from this text: $text"
          }
        ],
        "max_tokens": 20,
      }),
    );


    final data = jsonDecode(response.body);

    print("Response from OpenAI: $data");

    if (data.containsKey("choices") &&
        data["choices"] is List &&
        data["choices"].isNotEmpty &&
        data["choices"][0].containsKey("message") &&
        data["choices"][0]["message"].containsKey("content")) {
      return data["choices"][0]["message"]["content"].trim();
    } else {
      throw Exception("Invalid API response: $data");
    }
  }
}

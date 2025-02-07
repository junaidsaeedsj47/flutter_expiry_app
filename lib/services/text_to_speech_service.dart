import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakText(String? text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text!);
  }
}

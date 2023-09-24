import 'package:flutter_tts/flutter_tts.dart';

class TextToVoiceService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);

    //this rate should be dynamic as the senders rate of talking
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak(text);
  }
}
import 'package:flutter/material.dart';

class TextToVoiceModel extends ChangeNotifier {
  String _textToSpeak = '';
  String get textToSpeak => _textToSpeak;


  void setTextToSpeak(String text) {
    _textToSpeak = text;
    notifyListeners();
  }


}

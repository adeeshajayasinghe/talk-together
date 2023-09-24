import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/text_to_voice_model.dart';
import '../servises/text_to_voice_service.dart';


class TextToVoiceScreen extends StatefulWidget {
  const TextToVoiceScreen({Key? key}) : super(key: key);

  @override
  State<TextToVoiceScreen> createState() => _TextToVoiceScreenState();
}

class _TextToVoiceScreenState extends State<TextToVoiceScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text editing controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textToVoiceModel = Provider.of<TextToVoiceModel>(context);
    final textToSpeechService = TextToVoiceService();

    final elevatedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 4, 21, 51),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 21, 51),
        title: const Text('Text to Voice Conversion'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: const Color.fromARGB(255, 62, 56, 117),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              cursorColor: Colors.white,
              maxLines: 5,
              controller: textEditingController,
              style: TextStyle(color: Colors.white), // Set the text color here
              onChanged: (text) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                labelText: 'Enter text to convert',
                labelStyle: TextStyle(color: Colors.white), // Set label text color
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {
                    setState(() {
                      textEditingController.clear(); // Clear the text field using the controller
                    });
                  },
                  child: const Text('Clear'),
                ),
                const Spacer(),
                ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {
                    textToVoiceModel.setTextToSpeak(textEditingController.text); // Set text using the controller
                    final textToSpeak = textToVoiceModel.textToSpeak;
                    if (textToSpeak.isNotEmpty) {
                      textToSpeechService.speak(textToSpeak);
                    }
                  },
                  child: const Text('Convert to Voice'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

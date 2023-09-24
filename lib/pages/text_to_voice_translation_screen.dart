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

    // to directly speak, use this syntax below
    // textToSpeechService.speak('hi');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Voice Conversion'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              maxLines: 5,
              controller: textEditingController, // Set the controller here
              onChanged: (text) {
                // No need to use setState to update inputText
                // inputText = text;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                labelText: 'Enter text to convert',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      textEditingController.clear(); // Clear the text field using the controller
                    });
                  },
                  child: const Text('Clear'),
                ),
                const Spacer(),
                ElevatedButton(
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

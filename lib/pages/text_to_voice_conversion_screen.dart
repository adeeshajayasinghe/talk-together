import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:textapp/pages/Homepage.dart';
import '../models/text_to_voice_model.dart';
import '../servises/Auth.dart';
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
      backgroundColor: Color.fromARGB(255, 0, 3, 172),
      padding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );

    Auth auth = Auth();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 21, 51),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255), //change your color here
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Text to Voice",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            if (Auth.login)
              TextButton(
                  onPressed: () {
                    auth.SignOut();
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  )),
            IconButton(
                onPressed: () {
                  Get.offAll(HomePage());
                },
                icon: const Icon(Icons.home_filled))
          ]),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: const Color.fromARGB(255, 4, 21, 51),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
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
                  labelStyle:
                      TextStyle(color: Colors.white), // Set label text color
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      setState(() {
                        textEditingController
                            .clear(); // Clear the text field using the controller
                      });
                    },
                    child: const Text('Clear'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      textToVoiceModel.setTextToSpeak(textEditingController
                          .text); // Set text using the controller
                      final textToSpeak = textToVoiceModel.textToSpeak;
                      if (textToSpeak.isNotEmpty) {
                        textToSpeechService.speak(textToSpeak);
                      }
                    },
                    child: const Text('Convert to Voice'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

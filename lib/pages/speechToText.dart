import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:textapp/servises/AuthManager.dart';
import 'package:textapp/servises/text_to_voice_service.dart';
import 'package:translator/translator.dart';

import '../models/text_to_voice_model.dart';
import 'Homepage.dart';

class SpeechScreen extends StatefulWidget {
  final String toBeTranslateLanguage;
  const SpeechScreen({super.key,required this.toBeTranslateLanguage});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechtotext = SpeechToText();
  var text = "Start";
  var islisten = false;
  final translator = GoogleTranslator();
  

  @override
  Widget build(BuildContext context) {
    final textToVoiceModel = Provider.of<TextToVoiceModel>(context);
    final textToSpeechService = TextToVoiceService();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 21, 51),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: islisten,
        duration: Duration(milliseconds: 2000),
        glowColor: Color.fromARGB(255, 7, 238, 255),
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (_) async {
            if (!islisten) {
              var available = await speechtotext.initialize();
              if (available) {
                setState(() {
                  islisten = true;
                  speechtotext.listen(onResult: (value) {
                    setState(() {
                      print(value.recognizedWords);
                      text = translate(value.recognizedWords, widget.toBeTranslateLanguage);
                    });
                  });
                });
              }
            }
          },
          onTapUp: (_) => setState(() {
            islisten = false;
            speechtotext.stop();
          }),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            radius: 35,
            child: Icon(
              islisten ? Icons.mic : Icons.mic_none,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255), //change your color here
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Language",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            if (AuthManager.isLoggedIn)
              TextButton(
                  onPressed: () {
                  
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 7, 238, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal:24 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 3, 172),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        text = '';
                      });
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 0, 95),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    
                    onPressed: () {
                      textToVoiceModel.setTextToSpeak(text); // Set text using the controller
                      final textToSpeak = textToVoiceModel.textToSpeak;
                      if (textToSpeak.isNotEmpty) {
                        textToSpeechService.speak(textToSpeak);
                      }
                    },
                    child: Text(
                      'listen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //translate function
  translate(String source, String toBeTranslateLanguage) async {
    await translator.translate(source, from: 'en', to: toBeTranslateLanguage).then((value) {
      setState(() {
        text = value.toString();
      });
    });
  }
}

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../servises/Auth.dart';
import 'Homepage.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechtotext = SpeechToText();
  var text = "Start";
  var islisten = false;
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
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
                      text = value.recognizedWords;
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
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
              color: Color.fromARGB(255, 7, 238, 255), fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}

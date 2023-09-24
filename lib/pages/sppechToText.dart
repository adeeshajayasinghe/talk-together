import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechtotext = SpeechToText();
  var text = "Start";
  var islisten = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: islisten,
        duration: Duration(milliseconds: 2000),
        glowColor: Colors.black,
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
            backgroundColor: Colors.black,
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
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "Speech to text",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}

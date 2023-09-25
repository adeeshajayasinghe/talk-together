import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/models/Countries.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:textapp/pages/TakeCall.dart';
import 'package:textapp/pages/messege/messegePage.dart';
import 'package:textapp/servises/Auth.dart';
import 'package:textapp/widgets/GridB.dart';
import 'package:textapp/widgets/Selected_languge_display.dart';
import 'package:textapp/widgets/Title.dart';

class langugeSelection extends StatefulWidget {
  const langugeSelection({super.key});

  @override
  State<langugeSelection> createState() => _langugeSelectionState();
}

class _langugeSelectionState extends State<langugeSelection> {
  String speakingSelectedLang = '';
  String translatingSelectedLang = '';

  void updateSpeakingLanguage(String language) {
    setState(() {
      speakingSelectedLang = language;
    });
  }

  void updateTranslatingLanguage(String language) {
    setState(() {
      translatingSelectedLang = language;
    
    });
    print(translatingSelectedLang);
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Auth();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 21, 51),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            //this is the title. stylings are in the Title.dart file
            const TitleWidget(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Choose your \nlanguage",
                      style: TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 24, 20, 20),
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(
                      IconData(0xe67b, fontFamily: 'MaterialIcons'),
                      size: 70,
                      color: Color.fromARGB(255, 0, 238, 255),
                    ),
                  )
                ],
              ),
            ),

            //title of the speaking languages
            const SizedBox(
              height: 10,
            ),
            const Text("Speaking From?",
                style: TextStyle(color: Colors.white, fontSize: 22)),

            //grid view of the speaking languages. it is calling from the GridB class in widget folder
            Padding(
              padding: EdgeInsets.all(18.0),
              child: GridB(
                  setLang: updateSpeakingLanguage,
                  languages: SpeakinglanguageList),
            ),

            //calling widget to display selected Speaking language
            SelectedLanguageDiplayWidget(
                title: "speaking \nlanguage",
                ChangingVariable: speakingSelectedLang),

            const SizedBox(
              height: 16,
            ),
            const Text(
              "Translate To?",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),

            //grid view of the translating language list. it is calling from the GridB class in widget folder
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridB(
                    setLang: updateTranslatingLanguage,
                  languages: translatelanguageList),
            ),

            //calling widget to display selected Translating language
            SelectedLanguageDiplayWidget(
                title: "Translating \nlanguage",
                ChangingVariable: translatingSelectedLang),

            //button go to thee call
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                height: 45,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Color.fromARGB(255, 62, 56, 117))),
                child: TextButton(
                    onPressed: () {
                      print(translatingSelectedLang);
                      Get.to(() => Messege(
                        speakingSelectedLang: speakingSelectedLang,
                         TranslatingSelectedLang: translatingSelectedLang,
                      ));
                    },
                    child: const Text("Next",
                        style: TextStyle(fontSize: 18, color: Colors.blue))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

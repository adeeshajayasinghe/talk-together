import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:textapp/servises/Auth.dart';
import 'package:textapp/widgets/GridB.dart';
import 'package:textapp/widgets/Title.dart';

class langugeSelection extends StatefulWidget {
  const langugeSelection({super.key});

  @override
  State<langugeSelection> createState() => _langugeSelectionState();
}

class _langugeSelectionState extends State<langugeSelection> {
  String SelectedLange = '';

  void updateSelectedLanguage(String language) {
    setState(() {
      SelectedLange = language;
    });
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

            //grid view of the languages. it is calling from the GridB class in widget folder
            Padding(
              padding: EdgeInsets.all(24.0),
              child: GridB(setLang: updateSelectedLanguage),
            ),

            //showing speaking language
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 238, 255))),
                    child: const Center(
                        child: Text(
                      "speaking \nlanguage",
                      style: TextStyle(
                          color: Color.fromARGB(255, 182, 237, 253),
                          fontSize: 18),
                    )),
                  ),
                  Container(
                    height: 70,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 182, 237, 253)),
                    child: Center(
                        child: Text(
                      SelectedLange,
                      style: const TextStyle(
                          color: Color.fromARGB(232, 0, 0, 0), fontSize: 18),
                    )),
                  )
                ],
              ),
            ),

            //showing Hearing language
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 70,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Color.fromARGB(255, 0, 238, 255))),
                    child: const Center(
                        child: Text(
                      "speaking \nlanguage",
                      style: TextStyle(
                          color: Color.fromARGB(255, 182, 237, 253),
                          fontSize: 18),
                    )),
                  ),
                  Container(
                    height: 70,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 182, 237, 253)),
                    child: Center(
                        child: Text(
                      SelectedLange,
                      style: const TextStyle(
                          color: Color.fromARGB(232, 0, 0, 0), fontSize: 18),
                    )),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

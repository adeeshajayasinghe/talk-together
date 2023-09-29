import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:textapp/pages/SignUp.dart';
import 'package:textapp/pages/logIn.dart';
import 'package:textapp/servises/subcription.dart';
import 'package:textapp/widgets/inputs.dart';

import '../../servises/AuthManager.dart';
import '../speechToText.dart';

// ignore: must_be_immutable
class TakeCall extends StatelessWidget {
  String toBeTranslateLanguage;
  TakeCall({super.key, required this.toBeTranslateLanguage});

  final TextEditingController phonenNumber = TextEditingController();
  Subcription sub = Subcription();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 21, 51),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 255, 255), //change your color here
          ),
          backgroundColor: Colors.transparent,
          title: const Text(
            "Talk Together",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            if (!AuthManager.isLoggedIn)
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                  TextButton(
                      onPressed: () {
                        Get.to(const LogIn());
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      )),
                ],
              ),
            if (AuthManager.isLoggedIn)
              TextButton(
                  onPressed: () {
                    AuthManager.logout();
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  )),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'After you hit call button you will redirect to the transaltion page.',
              style: TextStyle(
                  color: Color.fromARGB(255, 7, 238, 255),
                  fontSize: 20,
                  fontFamily: AutofillHints.birthdayDay),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Inputs(
              keyboardType: TextInputType.phone,
              inputController: phonenNumber,
              title: "Phone No:",
              icon: const Icon(Icons.phone_android_rounded),
              hide: false),
          Container(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Center(
              child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 128, 255, 170)),
                  child: TextButton(
                      onPressed: () async {
                        _callNumber(context, toBeTranslateLanguage);
                      },
                      child: const Icon(
                        Icons.call,
                        size: 34,
                      ))),
            ),
          )
        ],
      ),
    );
  }

  _callNumber(BuildContext context, String languageToBeTrnslate) async {
    String number = phonenNumber.text; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SpeechScreen(
                toBeTranslateLanguage: languageToBeTrnslate,
              )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:textapp/pages/SignUp.dart';
import 'package:textapp/pages/logIn.dart';
import 'package:textapp/servises/subcription.dart';
import 'package:textapp/widgets/inputs.dart';

import '../../servises/AuthManager.dart';

// ignore: must_be_immutable
class TakeCall extends StatelessWidget {
  TakeCall({super.key});

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
          Inputs(
              keyboardType: TextInputType.phone,
              inputController: phonenNumber,
              title: "Phone No:",
              icon: const Icon(Icons.phone_android_rounded),
              hide: false),
          Container(
            decoration: const BoxDecoration(color: Colors.black26),
            child: Center(
                child: ElevatedButton(
                    onPressed: () async {
                      _callNumber();
                      
                    },
                    child: Text("call"))),
          ),
        ],
      ),
    );
  }

  _callNumber() async {
    String number = phonenNumber.text; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
    Get.to(SpeechToText());
  }
}

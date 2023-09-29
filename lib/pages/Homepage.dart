import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:textapp/pages/SignUp.dart';
import 'package:textapp/pages/languageSelection.dart';
import 'package:textapp/pages/logIn.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../servises/AuthManager.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key}); //instance of Auth class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 21, 51),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  height: 250,
                  width: 450,
                  child: SvgPicture.asset(
                    'Assets/translate-word (1).svg',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Talk Together",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color.fromARGB(255, 7, 238, 255),
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Talk Together translates and connects you with people from across the globe, making language barriers a thing to the past",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 40, 141),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    //function when click the getstarted button
                    onPressed: () {
                      _getStarted(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                                color: Color.fromARGB(255, 7, 238, 255),
                                fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_sharp,
                            size: 35,
                            color: Color.fromARGB(255, 7, 238, 255),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getStarted(BuildContext context) {
    if (AuthManager.isLoggedIn) {
      Get.to(() => langugeSelection());
      //Get.to(Calling());
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.rotate,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: "Please Login",
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:textapp/pages/logIn.dart';
import 'package:textapp/servises/Auth.dart';
import 'package:textapp/widgets/Title.dart';
import 'package:textapp/widgets/inputs.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    //controller to get inputs
    final fullName = TextEditingController();
    final email = TextEditingController();
    final mobile = TextEditingController();
    final password = TextEditingController();

    //Auth() class instance to call Authentication  method
    Auth auth = Auth();

    //dispose
    void dispose() {
      fullName.text = '';
      email.text = '';
      mobile.text = '';
      password.text = '';
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 21, 51),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "transPeaker",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.offAll(HomePage());
              },
              icon: const Icon(
                Icons.home_filled,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //this sized box is for taking the space from top
            const SizedBox(
              height: 130,
            ),

            //this is the title. stylings are in the Title.dart file
            const TitleWidget(
              content: Text("Sign up",
                  style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 24, 20, 20),
                      fontWeight: FontWeight.bold)),
            ),

            const SizedBox(
              height: 10,
            ),
            //fullName input
            Inputs(
                hide: false,
                title: "Full Name",
                inputController: fullName,
                icon: Icon(Icons.person_2_rounded)),

            //email input
            Inputs(
                hide: false,
                title: "Email",
                inputController: email,
                icon: Icon(Icons.email_rounded)),

            //mobile input
            Inputs(
                hide: false,
                title: "Mobile",
                inputController: mobile,
                icon: Icon(Icons.mobile_friendly_rounded)),

            //password input
            Inputs(
                hide: true,
                title: "Password",
                inputController: password,
                icon: Icon(Icons.password)),

            const SizedBox(
              height: 13,
            ),

            //register button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 166, 172, 219),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton(
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          auth.signUpUser(fullName.text, mobile.text,
                              email.text, password.text);

                          dispose();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(LogIn());
                        },
                        child: const Text("Log in",
                            style: TextStyle(fontSize: 18, color: Colors.blue)))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

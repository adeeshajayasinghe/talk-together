import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:textapp/pages/SignUp.dart';
import 'package:textapp/servises/Auth.dart';
import 'package:textapp/servises/googleSignIn.dart';
import 'package:textapp/widgets/Title.dart';
import 'package:textapp/widgets/inputs.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final UserName = TextEditingController();
    final password = TextEditingController();

    //Auth() class instance to call Authentication  method
    Auth auth = Auth();
    AuthService google = AuthService();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 21, 51),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255), //change your color here
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
          children: [
            //this sized box is for taking the space from top
            const SizedBox(
              height: 120,
            ),

            //this is the title. stylings are in the Title.dart file
            const TitleWidget(
              content: Text("Log in",
                  style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 24, 20, 20),
                      fontWeight: FontWeight.bold)),
            ),

            const SizedBox(
              height: 50,
            ),
            //fullName input
            Inputs(
                title: "User Name/Email",
                hide: false,
                inputController: UserName,
                icon: Icon(Icons.person_2_rounded)),

            //email input
            Inputs(
                hide: true,
                title: "Password",
                inputController: password,
                icon: Icon(Icons.email_rounded)),

            //forget password
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue, fontSize: 19),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 55,
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
                  child: TextButton(
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () {
                      auth.signInUser(UserName.text, password.text);
                    },
                  ),
                ),
                const SizedBox(height: 10),

                //google sign in button
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("Assets/7123025_logo_google_g_icon.png"),
                        const Text(
                          "Google Sign in",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    onPressed: () {
                      //auth.signInUser(UserName.text, password.text);
                      //Sign in with google
                      google.signInWithGoogle();
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have an account? ?",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(()=>const SignUp());
                        },
                        child: const Text("Sign Up",
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

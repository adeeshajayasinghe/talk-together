import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:textapp/pages/SignUp.dart';

class Auth {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  static bool login = false;

  //firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signUpUser(BuildContext context, String fullName, String mobile,
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: password); //authentication user

      print(userCredential.user);

      //instance of the collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Call the user's CollectionReference to add a new user
      users.add({
        'full_name': fullName, // John Doe
        'mobile': mobile, // Stokes and Sons
        'email': email // 42
      }).then((value) => const AlertDialog(
            title: Text("Successfully registeres"),
            content: Text(
                'We have sent you a verification email. please verify your email'),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //print('The account already exists for that email.');
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: ((context) => AlertDialog(
                  title: Text("Error"),
                  content: const Text(
                      "this email has already registered. try to log in"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.off(SignUp());
                        },
                        child: Text("Cancel")),
                  ],
                )));
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<User?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user);
      Get.offAll(
          HomePage()); //redirect to the Home page after successful logged in
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

//signOut function. this function delete the use id from the initial local storage
  Future<User?> SignOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(HomePage());
    return null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:textapp/pages/Homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:textapp/servises/Auth.dart';

import 'firebase_options.dart';
import 'models/text_to_voice_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
      Auth.login = false;
    } else {
      print('User is signed in!');
      Auth.login = true;
    }
  });

  runApp(ChangeNotifierProvider(
      create: (context) => TextToVoiceModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:textapp/pages/Homepage.dart';

class AuthService {
  //Google sign in
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain with details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credentials for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    //lets sign in
    // UserCredential userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAll(() => HomePage());
  }
}

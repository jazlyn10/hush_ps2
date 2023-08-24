import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  //Google sign-in
  signinWithGoogle() async{
    //begin interactive google sign-in
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();
  //obtain auth details from request
    final GoogleSignInAuthentication gAuth=await gUser!.authentication;


    //create new credentials
    final credential =GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally bc
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
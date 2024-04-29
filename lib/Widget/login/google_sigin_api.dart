


import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSigIn = GoogleSignIn();

  static Future login() => _googleSigIn.signIn();
}
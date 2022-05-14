import 'package:google_sign_in/google_sign_in.dart';

class OAuth {
  static final _googleSignin = GoogleSignIn();

  static login() => _googleSignin.signIn();
  static logout() => _googleSignin.disconnect();
  static isSignedIn() => _googleSignin.isSignedIn();
}

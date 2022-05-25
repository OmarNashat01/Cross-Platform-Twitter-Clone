import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter/constants.dart';
import 'package:http/http.dart' as http;


class OAuth {
  static final _googleSignin = GoogleSignIn();

  static login() => _googleSignin.signIn();
  static logout() => _googleSignin.disconnect();
  static isSignedIn() => _googleSignin.isSignedIn();

  static Future<http.Response> signup() async {


    final uri =
        Uri.http(Http().getBaseUrl(), '/signup/google');

    final response = await http.get(uri);
    return response;
  }
}

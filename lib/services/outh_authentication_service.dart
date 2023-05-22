import 'package:google_sign_in/google_sign_in.dart';

class OauthAuthenticationService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.body.read',
    "https://www.googleapis.com/auth/fitness.location.read",
    "https://www.googleapis.com/auth/fitness.heart_rate.read",
  ]);
  static GoogleSignInAccount? _account;
  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  static Future<bool> signIn() async {
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    _account = account;

    if (account != null) return true;
    return false;
  }

  static Future<bool> trySignInSilently() async {
    GoogleSignInAccount? account = await _googleSignIn.signInSilently();
    _account = account;
    if (account != null) return true;
    return false;
  }

  static Future<bool> signOut() async {
    GoogleSignInAccount? account = await _googleSignIn.signOut();

    return true;
  }

  static String? get userName => _account?.displayName;
  static String? get profilePhoto => _account?.photoUrl;

  static Future<String?> get token async {
    final data = await _account?.authentication;
    return data?.accessToken;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static Future<User?> signInWithGoogle() async {
    final FirebaseAuth _auth = await FirebaseAuth.instance;

    // await Firebase.initializeApp();

    final GoogleSignIn gsi = GoogleSignIn();
    final GoogleSignInAccount? gAccount = await gsi.signIn();
    if (gAccount == null) {
      return null;
    }

    final GoogleSignInAuthentication gsiAuth = await gAccount.authentication;
    if (gsiAuth.accessToken == null) {
      throw Exception("Failed to retrieve authentication tokens.");
    }

    final AuthCredential ac =
        GoogleAuthProvider.credential(accessToken: gsiAuth.accessToken!);

    try {
      final UserCredential uc = await _auth.signInWithCredential(ac);
      final User? user = uc.user;
      if (user != null) {
        // save accessToken, idToken
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', gsiAuth.accessToken!);
      } else {
        throw Exception('Failed to sign in user.');
      }
      return user;
    } catch (e) {
      print('Error during sign in with Google: $e');
      return null;
    }
  }

  static Future<void> googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In
      await GoogleSignIn().signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }

  static Future<User?> signInWithSavedCredentials() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      final AuthCredential ac =
          GoogleAuthProvider.credential(accessToken: accessToken);

      try {
        final UserCredential uc = await _auth.signInWithCredential(ac);
        final User? user = uc.user;
        return user;
      } catch (e) {
        await prefs.remove('accessToken');
        print(e.toString());
      }
    }

    return null; // Sign-in otomatis gagal
  }
}

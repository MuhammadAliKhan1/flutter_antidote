import 'package:antidote/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../global.dart';

class LoginService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> initiateFacebookLogin() async {
    try {
      FacebookLoginResult facebookAuth = await _handleFacebookSignIn();
      AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: facebookAuth.accessToken.token,
      );
      FirebaseUser user = (await auth.signInWithCredential(credential)).user;

      await _setUserToFireStore(user);
      await prefHandle.setPreference('email', user.email);
      print(user.email);
      return user.email;
    } catch (e) {
      print(e);
    }
  }

  Future<String> initiateGoogleLogin() async {
    try {
      GoogleSignInAuthentication googleAuth = await _handleGoogleSignIn();

      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("credential $credential");
      AuthResult authResult = (await auth.signInWithCredential(credential));
      print(authResult.user.email);
      await _setUserToFireStore(authResult.user);
      await prefHandle.setPreference('email', authResult.user.email);
      print("User Email ${authResult.user.email}");
      return authResult.user.email;
    } catch (e) {
      print(e);
    }
  }

  Future _setUserToFireStore(FirebaseUser user) async {
    CollectionReference reference = await Firestore.instance
        .collection(FireStoreKeys.patientUsersCollection);

    var snapshot = await reference.document(user.email).get();
    if (!snapshot.exists) {
      var appUser = User(
        name: user.displayName,
        mobileNumber: user.phoneNumber,
        id: user.email,
        photoUrl: user.photoUrl,
        email: user.email,
      );
      await reference
          .document(user.email)
          .setData(appUser.toJson(), merge: true);
    }

    await prefHandle.clearPreferences();
  }

  Future<GoogleSignInAuthentication> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await googleLogin.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    print("Google auth $googleAuth");
    return googleAuth;
  }

  Future<FacebookLoginResult> _handleFacebookSignIn() async {
    FacebookLoginResult facebookUser = await facebookLogin.logIn(['email']);
    return facebookUser;
  }

  initialize() {
    Firestore.instance.settings(
      persistenceEnabled: true,
    );
  }
}

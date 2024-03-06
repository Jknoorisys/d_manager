import 'package:google_sign_in/google_sign_in.dart';

import '../helpers/auth_interface.dart';


class GoogleAuth implements AuthInterface {
  GoogleAuth();

  @override
  Future<SocialResponse?> signUp() async {
    try {
      await GoogleSignIn().signOut();
      var googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        return SocialResponse(
            uid: googleUser.id,
            name: googleUser.displayName,
            email: googleUser.email,
            photoUrl: googleUser.photoUrl);
      } else {
        return null;
      }
      //
      // print(googleUser?.email);
      //
      // // Obtain the auth details from the request
      // final googleAuth = await googleUser?.authentication;
      //
      // // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );
      //
      //
      // // Once signed in, return the UserCredential
      // final user = await FirebaseAuth.instance.signInWithCredential(credential);
      // print(user.user?.email);
      // print(user.user?.displayName);
      //
      // // return user;
    } finally {}
  }

  @override
  Future<void> logIn() {
    // TODO: implement logIn
    throw UnimplementedError();
  }
}

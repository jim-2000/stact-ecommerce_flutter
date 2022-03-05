import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stack/screens/Landing/Landing.dart';
import 'package:stack/screens/auth/Login.dart';
import 'package:stack/screens/auth/SignUpScreen.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods globalMethods = GlobalMethods();
  Future<void> loginwithMail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
//

    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.toLowerCase().trim(), password: password.trim())
          .then((value) =>
              Navigator.canPop(context) ? Navigator.pop(context) : null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        globalMethods.authDialoge(
            context, "wrong-password", "Try to forgot password");
      } else if (e.code == 'invalid-email') {
        globalMethods.authDialoge(
            context, "invalid-email", "Try to use Valid email");
      } else if (e.code == 'user-not-found') {
        globalMethods.authDialoge(
            context, "user-not-found", "user-not-found try to register");
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
        });
      }
      // globalMethods.authDialoge(context, "Try again", "Something went wrong");
      globalMethods.authDialoge(context, e.code, e.message.toString());

      Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
    }
    notifyListeners();
  }

  Future<void> registerWithMail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password.trim());
      Navigator.canPop(context)
          ? Navigator.pop(context)
          : Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
    } catch (e) {
      // if (e.code == 'account-exists-with-different-credential') {
      //   globalMethods.authDialoge(
      //     context,
      //     "This email is already registered with different credential",
      //     "account-exists-with-different-credential",
      //   );
      // }
      // if (e.code == 'email-already-in-use') {
      //   globalMethods.authDialoge(
      //       context, "This Email is alrady used", "Try to forgot password");
      //   // Navigator.pop(context);
      // } else if (e.code == 'invalid-email') {
      //   globalMethods.authDialoge(
      //       context, "invalid-email", "Try to use Valid email");
      //   // Navigator.pop(context);
      // } else if (e.code == 'weak-password') {
      //   globalMethods.authDialoge(
      //       context, "weak-password", "Use Strong password");
      //   // Navigator.pop(context);
      // } else {
      //   globalMethods.authDialoge(context, e.code, e.message.toString());
      //   Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
      // }
      globalMethods.authDialoge(context, "Try again", "Something went wrong");
    }
    notifyListeners();
  }

  void logout({required BuildContext context}) async {
    await _auth.signOut();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, LandingScreen.routeName);
    });
    notifyListeners();
  }
}

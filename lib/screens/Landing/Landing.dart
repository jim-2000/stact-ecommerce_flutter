import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/screens/auth/Login.dart';
import 'package:stack/screens/auth/SignUpScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stack/widgets/alerts/global_Dialog.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = 'landing_screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalMethods _globalMethods = GlobalMethods();

  bool _isLoading = false;

//
  final List<String> _images = [
    'assets/images/shopping1.jpeg',
    'assets/images/shopping2.jpeg',
  ];
// annonimous loging

  void _anonimousLogin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInAnonymously().then(
          (value) => Navigator.canPop(context) ? Navigator.pop(context) : null);
    } on FirebaseAuthException catch (e) {
      _globalMethods.authDialoge(context, e.code, e.message.toString());
      // ignore: avoid_print
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

// google signin
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential

    final date = DateTime.now().toString();
    final parseDate = DateTime.parse(date);
    final formatedDate =
        '${parseDate.day}/${parseDate.month}/${parseDate.year}';
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user!.uid)
        .set({
      'uid': authResult.user!.uid,
      'email': authResult.user!.email!.toLowerCase(),
      'fullName': authResult.user!.displayName!.trim(),
      'phoneNumber': authResult.user!.phoneNumber,
      'image': authResult.user!.photoURL,
      'joinedDate': formatedDate,
      'created': Timestamp.now(),
    });
    return authResult;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              _images[0],
              fit: BoxFit.cover,
              // alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                child: const Text(
                  'Welcome to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              RichText(
                  text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Stack Shop",
                    style: TextStyle(
                      fontSize: 55,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "By Flutter",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.teal,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LogInScreen.routeName);
                      },
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                      child: Text('Signup'),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _anonimousLogin,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.people),
                          Text('Go to Guest'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: signInWithGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.facebook_outlined),
                          Text('Google'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}

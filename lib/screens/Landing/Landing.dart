import 'package:flutter/material.dart';
import 'package:stack/navScreens/bottom_nav_Screen.dart';
import 'package:stack/screens/auth/Login.dart';
import 'package:stack/screens/auth/SignUpScreen.dart';
import 'package:stack/screens/homeScreen.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = 'landing_screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animatedController;
  late Animation<double> _animation;
//
  List<String> _images = [
    'assets/images/shopping1.jpeg',
    'assets/images/shopping2.jpeg',
  ];

//

  @override
  void initState() {
    _images.shuffle();
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animatedController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animatedController.reset();
              _animatedController.forward();
            }
          });
    _animatedController.forward();
    // TODO: implement initState
    super.initState();
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
              alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          //

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              SizedBox(height: 50),
              Container(
                width: double.infinity,
                child: Text(
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
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, BottomNavScreen.routesName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people),
                          Text('Go to Guest'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook_outlined),
                          Text('Facebook'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}

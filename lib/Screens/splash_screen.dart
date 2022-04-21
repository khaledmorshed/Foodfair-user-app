import 'dart:async';
import 'package:flutter/material.dart';
import 'auth_screen.dart';
import 'user_home_screen.dart';
import '../global/global_instance_or_variable.dart';

class SplashScreen extends StatefulWidget {
  static final String path = "/SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async {
      //in if now current user is registered and it is save lacallly with sharedPreferences
      if (firebaseAuth.currentUser != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserHomeScreen()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AuthScreen()));
      }
      // Navigator.push(
      //   context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/images/delivery.jpg",
                  scale: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Order Food Online",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

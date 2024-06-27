import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/pages/OnboardingScreen.dart';
import 'package:google_fonts/google_fonts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(
        const Duration(seconds: 8),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Onboarding())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C2DA5),
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 320,
              ),
              Image.asset(
                "assets/logo.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "KARITY",
                style: GoogleFonts.breeSerif(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:littlab/controller/auth_provider.dart';
import 'package:littlab/view/auth/login_page.dart';
import 'package:littlab/view/widget/bottombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Top Icon or Logo
          Padding(
            padding: EdgeInsets.only(
              right: screenWidth * 0.2,
            ),
            child: Container(
              height: screenHeight * 0.4,
              width: screenWidth * 0.80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash image.png'), // Icon image
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          // Text Container
          Container(
            height: screenHeight * 0.3,
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.01),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover your Next Skill\Learn anything you want',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: screenHeight * 0.020,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Discover the things you want to learn\nand grow with them',
                        style: TextStyle(
                          color: const Color.fromARGB(221, 108, 104, 104),
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                  // Positioned Button
                  Positioned(
                    bottom: 15,
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      width: screenWidth * 0.78,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6C63FF),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.1),
        ],
      ),
    );
  }

  goToLogin(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final userProvider = Provider.of<LoginProvider>(context, listen: false);

    if (currentUser == null) {
      await Future.delayed(Duration(minutes: 30));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      await userProvider.getUser();
      await Future.delayed(Duration(minutes: 30));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomScreen()),
      );
    }
  }
}

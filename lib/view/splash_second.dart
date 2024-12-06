import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:littlab/view/widget/text.dart';
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
        children: [
          // Splash Image Section
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash image.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // Text Container Section
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title Text
                      textPoppins(
                        name:
                            'Discover your Next Skill \nLearn anything you want!',
                        fontsize: screenHeight * 0.02,
                        color: Colors.black,
                        fontweight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Subtitle Text
                      textPoppins(
                        name:
                            'Discover the things you want to learn\nand grow with them.',
                        fontsize: screenHeight * 0.018,
                        color: const Color.fromARGB(255, 108, 103, 103),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Get Started Button
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  goToLogin(context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final UserPrvd = Provider.of<LoginProvider>(context, listen: false);

    if (currentUser == null) {
      await Future.delayed(
        Duration(seconds: 3),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      CircularProgressIndicator();
      await UserPrvd.getUser();
      await Future.delayed(
        Duration(seconds: 3),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomScreen()));
    }
  }
}

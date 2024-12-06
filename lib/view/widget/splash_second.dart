import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_litltab/controller/auth_provider.dart';
import 'package:flutter_litltab/view/auth/login_page.dart';
import 'package:flutter_litltab/view/widget/bottombar.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://c8.alamy.com/comp/KNT447/elearning-logo-ebook-e-learning-and-knowledge-base-concept-stock-illustration-KNT447.jpg'),
          )),
        ),
      ),
    );
  }

  goToLogin(context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final UserPrvd = Provider.of<LoginProvider>(context, listen: false);

    if (currentUser == null) {
      await Future.delayed(
        Duration(seconds: 2),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      CircularProgressIndicator();
      await UserPrvd.getUser();
      await Future.delayed(
        Duration(seconds: 2),
      );
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomScreen()));
    }
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:littlab/controller/auth_provider.dart';
import 'package:littlab/controller/bottom.dart';
import 'package:littlab/controller/course_provider.dart';
import 'package:littlab/firebase_options.dart';
import 'package:littlab/view/widget/splash_second.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CourseProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

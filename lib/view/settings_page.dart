import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlab/controller/auth_provider.dart';
import 'package:littlab/controller/bottom.dart';
import 'package:littlab/view/auth/login_page.dart';
import 'package:littlab/view/widget/text.dart';

import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bottomProvider = Provider.of<BottomProvider>(context, listen: false);
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    final firebaseauth = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<LoginProvider>(
          builder: (context, value, child) => Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Row(
                children: [
                  SizedBox(width: size.width * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAbel(
                        name: value.currentUser?.name ?? 'Unknown',
                        color: const Color(0xFF1D1617),
                        fontsize: size.width * 0.05,
                      ),
                      SizedBox(height: size.height * 0.008),
                      textPoppins(
                        name: value.currentUser?.email ??
                            firebaseauth?.email ??
                            'no email',
                        color: const Color(0xFF888888),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              const Divider(
                color: Color.fromARGB(255, 186, 186, 186),
              ),
              const Divider(
                color: Color.fromARGB(255, 186, 186, 186),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.9,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                        color: const Color.fromARGB(255, 238, 236, 236)),
                  ),
                  onPressed: () {
                    alertSheet(
                      context,
                      alertMessage: 'ARE YOU SURE TO LOGOUT ?',
                      onPressed: () async {
                        // bottomProvider.setInitIndex(0);
                        await FirebaseAuth.instance.signOut();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                        bottomProvider.currentIndex = 0;
                      },
                      confirmButtonLabel: 'LOGOUT',
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              SizedBox(height: 30),
              const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}

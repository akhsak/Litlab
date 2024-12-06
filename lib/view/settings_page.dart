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
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          // Use Consumer to get LoginProvider data
          builder: (context, value, child) => Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(
                        'https://www.example.com/profile-pic.jpg', // Replace with a dynamic image URL
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textAbel(
                          name: value.currentUser?.name ?? 'Unknown',
                          color: const Color(0xFF1D1617),
                          fontsize: size.width * 0.06,
                        ),
                        SizedBox(height: size.height * 0.008),
                        textPoppins(
                          name: value.currentUser?.email ??
                              firebaseauth?.email ??
                              'No email',
                          color: const Color(0xFF888888),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Divider(
                color: Color.fromARGB(255, 186, 186, 186),
                thickness: 1.5,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 88, 84, 84), // text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 2),
                  ),
                  onPressed: () {
                    alertSheet(
                      context,
                      alertMessage: 'Are you sure you want to logout?',
                      onPressed: () async {
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
                      confirmButtonLabel: 'Logout',
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

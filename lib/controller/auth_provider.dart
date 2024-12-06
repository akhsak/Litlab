import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:littlab/model/auth_model.dart';
import 'package:littlab/service/auth_service.dart';
import 'package:littlab/view/widget/bottombar.dart';
import 'package:littlab/view/widget/text.dart';

class LoginProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final fillAccountFormkey = GlobalKey<FormState>();

  final signUpFormKey = GlobalKey<FormState>();

  final forgotPasswordFormkey = GlobalKey<FormState>();
  bool isAdminHome = false;

  String? emailError;
  String? passwordError;
  // bool obscureText = true;
  int currentIndex = 0;
  UserModel? currentUser;
  bool showPassword = true;

  bool loginObscureText = true;
  void loginObscureTextchange() {
    loginObscureText = !loginObscureText;
    notifyListeners();
  }

  bool createObscureText = true;
  void createObscureTextchange() {
    createObscureText = !createObscureText;
    notifyListeners();
  }

  Future<void> forgotPassword(context, {email}) async {
    authService.passwordReset(email: email, context: context);
  }

  void clearSignupControllers() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();

    ageController.clear();
  }

  void clearLoginControllers() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
        .hasMatch(value)) {
      emailError = 'Please enter a valid email address';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Please enter your password';
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  Future<UserCredential> signupUser(
      String email, String password, String age, String userName) async {
    return await authService.signUpWithEmail(
      email: email,
      password: password,
      age: age,
      userName: userName,
    );
  }

  Future<UserCredential> loginWithEmail(String email, String password) async {
    return await authService.signInWithEmail(email, password);
  }

  Future<void> signOutWithEmail() async {
    return await authService.signOutEmail();
  }

  userKey(context, SnackBarWidget snackBarWidget, {String? message}) async {
    try {
      await loginWithEmail(
          loginEmailController.text, loginPasswordController.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomScreen()),
          (route) => false);
      clearControllers();
    } catch (error) {
      snackBarWidget.showErrorSnackbar(context, message!);
    }
  }

  addUser(BuildContext context) async {
    final user = UserModel(
      email: emailController.text,
      name: userNameController.text,
      age: ageController.text,
      uId: firebaseAuth.currentUser!.uid,
    );
    await authService.addUser(user, context);
    getUser();
  }

  Future<void> getUser() async {
    currentUser = await authService.getCurrentUser();
    if (currentUser != null) {
      log(currentUser!.email!);
    }
    notifyListeners();
  }

  updateUser(userid, UserModel data) async {
    await authService.updateUser(data);
    clearSignupControllers();
    notifyListeners();
  }

  Future<void> updateUserProfile(
      String fullName, String age, String email, String profilepic) async {
    if (currentUser != null) {
      currentUser!.name = fullName;
      currentUser!.age = age;
      currentUser!.email = email;
      notifyListeners();
    }
  }

  Future clearControllers() async {
    userNameController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();

    ageController.clear();

    notifyListeners();
  }

  // onTabTapped(int index) {
  //   currentIndex = index;
  //   notifyListeners();
  // }

  Future<UserModel?> getUserById(String userId) async {
    try {
      UserModel? user = await authService.getUserById(userId);
      return user;
    } catch (e) {
      log('Error fetching user by ID in AuthenticationProvider: $e');
      return null;
    }
  }
}

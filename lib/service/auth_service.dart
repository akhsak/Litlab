// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_litltab/model/auth_model.dart';

// class AuthService {
//   String? verificationid;
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   String collection = 'user';
//   Reference storage = FirebaseStorage.instance.ref();

//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<void> addUser(UserModel data) async {
//     try {
//       await firestore
//           .collection(collection)
//           .doc(firebaseAuth.currentUser!.uid)
//           .set(data.toJson());
//     } catch (e) {
//       const ScaffoldMessenger(
//         child: Text('User not Added'),
//       );
//     }
//   }

//   Future<UserModel?> getCurrentUser() async {
//     User? user = firebaseAuth.currentUser;
//     if (user != null) {
//       DocumentSnapshot doc =
//           await firestore.collection(collection).doc(user.uid).get();
//       if (doc.exists) {
//         return UserModel.fromJson(doc.data() as Map<String, dynamic>);
//       }
//     }
//     return null;
//   }

//   Future<UserCredential> signUpWithEmail({
//     required String email,
//     required String password,
//     required String userName,
//     required String age,
//   }) async {
//     try {
//       UserCredential userCredential =
//           await firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       UserModel userData = UserModel(
//         email: email,
//         uId: userCredential.user?.uid,
//         name: userName,
//         age: age,
//       );
//       await firestore
//           .collection(collection)
//           .doc(userCredential.user?.uid)
//           .set(userData.toJson());
//       log('Account created');
//       return userCredential;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<UserCredential> signInWithEmail(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       log('User logged in');
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.code);
//     }
//   }

//   Future<void> signOutEmail() async {
//     await firebaseAuth.signOut();
//   }

//   void passwordReset({required email, context}) async {
//     try {
//       log('start');
//       await firebaseAuth.sendPasswordResetEmail(email: email);
//       log('success');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Password reset email sent"),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       log('error occure');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             e.message.toString(),
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> updateUser(UserModel data) async {
//     try {
//       if (firebaseAuth.currentUser != null) {
//         await firestore
//             .collection(collection) // Using 'user'
//             .doc(firebaseAuth.currentUser!.uid)
//             .update(data.toJson());
//       } else {
//         throw Exception('No current user found');
//       }
//     } catch (e) {
//       log('Error updating user: $e');
//     }
//   }

//   Future<List<UserModel>> getAllUsers() async {
//     try {
//       QuerySnapshot querySnapshot =
//           await firestore.collection(collection).get();
//       List<UserModel> users = querySnapshot.docs.map((doc) {
//         return UserModel.fromJson(doc.data() as Map<String, dynamic>);
//       }).toList();

//       return users;
//     } catch (e) {
//       log('Error fetching users: $e');
//       return [];
//     }
//   }

//   Future<UserModel?> getUserById(String userId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await firestore.collection(collection).doc(userId).get();

//       if (snapshot.exists && snapshot.data() != null) {
//         return UserModel.fromJson(snapshot.data()!);
//       } else {
//         log('User not found with ID: $userId');
//         return null;
//       }
//     } catch (e) {
//       log('Error fetching user by ID: $e');
//       return null;
//     }
//   }
// }
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_litltab/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String? verificationid;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String collection = 'user';
  Reference storage = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserModel data, BuildContext context) async {
    try {
      await firestore
          .collection(collection)
          .doc(firebaseAuth.currentUser!.uid)
          .set(data.toJson());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not added')),
      );
      log('Error adding user: $e');
    }
  }

  Future<UserModel?> getCurrentUser() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await firestore.collection(collection).doc(user.uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String userName,
    required String age,
  }) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userData = UserModel(
        email: email,
        uId: userCredential.user?.uid,
        name: userName,
        age: age,
      );
      await firestore
          .collection(collection)
          .doc(userCredential.user?.uid)
          .set(userData.toJson());
      log('Account created');

      // Save user data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('uid', userCredential.user!.uid);

      return userCredential;
    } catch (e) {
      log('Sign-up error: $e');
      rethrow;
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User logged in');

      // Save user data to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('uid', userCredential.user!.uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('Login error: $e');
      throw Exception(e.code);
    }
  }

  Future<void> signOutEmail() async {
    try {
      await firebaseAuth.signOut();

      // Clear SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      log('User logged out');
    } catch (e) {
      log('Sign-out error: $e');
    }
  }

  void passwordReset({required String email, required BuildContext context}) async {
    try {
      log('Start password reset');
      await firebaseAuth.sendPasswordResetEmail(email: email);
      log('Password reset email sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      log('Error during password reset: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred'),
        ),
      );
    }
  }

  Future<void> updateUser(UserModel data) async {
    try {
      if (firebaseAuth.currentUser != null) {
        await firestore
            .collection(collection)
            .doc(firebaseAuth.currentUser!.uid)
            .update(data.toJson());
        log('User updated successfully');
      } else {
        throw Exception('No current user found');
      }
    } catch (e) {
      log('Error updating user: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(collection).get();
      List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return users;
    } catch (e) {
      log('Error fetching users: $e');
      return [];
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection(collection).doc(userId).get();

      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      } else {
        log('User not found with ID: $userId');
        return null;
      }
    } catch (e) {
      log('Error fetching user by ID: $e');
      return null;
    }
  }

  Future<Map<String, String?>> getSavedUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? uid = prefs.getString('uid');
    return {'email': email, 'uid': uid};
  }
}

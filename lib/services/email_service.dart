// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// class EmailService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }

//   final String userEmail = "g0548457103@gmail.com";
//   final String userPassword = "mjdr ibfp rojk icbz";

//   // Future<UserCredential> loginWithEmailPassword(String email, String password) async {
//   //   try {
//   //     // Check if the email exists
//   //     List<String> signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

//   //     if (signInMethods.contains('password')) {
//   //       // If email exists, send code to the email
//   //       await sendVerificationCode(email);
//   //       throw Exception("Email already exists. A code has been sent to your email.");
//   //     } else {
//   //       // If email doesn't exist, create a new user
//   //       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//   //         email: email,
//   //         password: password,
//   //       );

//   //       await _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set(
//   //         {
//   //           'uid': userCredential.user!.uid,
//   //           'email': email,
//   //         },
//   //         SetOptions(merge: true),
//   //       );

//   //       // Send the code to the email
//   //       await sendVerificationCode(email);

//   //       return userCredential;
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     throw Exception(e.code);
//   //   }
//   // }

//   // String generateVerificationCode(){
//   //   final randon = Random();
//   //   return List<int>.generate(6, (index) => randon.nextInt(10)).join();
//   // }

//   Future<void> sendVerificationCode(String email) async {
//     final random = Random();
//     final code = List<int>.generate(6, (index) => random.nextInt(10)).join();

//     final smtpServer = gmail(userEmail, userPassword);
//     final message = Message()
//       ..from = Address(userEmail, 'Coffee Shop')
//       ..recipients.add(email)
//       ..subject = 'Your Verification Code'
//       ..text = 'Your verification code is: $code';

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent. \n${e.toString()}');
//     }
//   }

//   // Future<UserCredential> loginWithEmailPassword(String email, String password) async {
//   //   try {
//   //     // Check if the email exists
//   //     List<String> signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);

//   //     if (signInMethods.contains('password')) {
//   //       // If email exists, send code to the email
//   //       await sendCodeToEmail(email);
//   //       throw Exception("Email already exists. A code has been sent to your email.");
//   //     } else {
//   //       // If email doesn't exist, create a new user
//   //       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//   //         email: email,
//   //         password: password,
//   //       );

//   //       await _firebaseFirestore.collection('Users').doc(userCredential.user!.uid).set(
//   //         {
//   //           'uid': userCredential.user!.uid,
//   //           'email': email,
//   //         },
//   //         SetOptions(merge: true),
//   //       );

//   //       // Send the code to the email
//   //       await sendCodeToEmail(email);

//   //       return userCredential;
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     throw Exception(e.code);
//   //   }
//   // }

  

//   // Future<void> logOut() async {
//   //   return await _firebaseAuth.signOut();
//   // }
// }












import 'dart:math';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  final String username = 'g0548457103@gmail.com';
  final String password = 'mjdr ibfp rojk icbz';

  String generateVerificationCode() {
    final random = Random();
    return List<int>.generate(6, (index) => random.nextInt(10)).join();
  }

  Future<void> sendVerificationEmail(String email, String code) async {
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Coffee Shop')
      ..recipients.add(email)
      ..subject = 'Verification Code'
      ..text = 'Your verification code is: $code';

    try {
      await send(message, smtpServer);
      print('Verification email sent');
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
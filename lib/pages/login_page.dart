// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coffee_shop/components/my_button.dart';
// import 'package:coffee_shop/const.dart';
// import 'package:coffee_shop/services/email_service.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'home_page.dart';

// class LoginPage extends StatefulWidget{
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage>{
//   final emailController = TextEditingController();
//   final codeController = TextEditingController();
//   // final verificationCodeController = TextEditingController();

//   final emailService = EmailService();
//   // bool isSendingCode = false;
//   // bool isVerifyingCode = false;
//   // bool isSigningIn = false;

//   String? _verificationCode;

//   void signInWithEmailCode() async {
//   //   setState(() {
//   //     isSigningIn = true;
//   //   });

//   //   try{
//   //     await emailService.loginWithEmailPassword(
//   //       emailController.text.trim(),
//   //       codeController.text.trim(),
//   //     );
//   //   }catch(e) {}

//     String email = emailController.text.trim();
//     String code = codeController.text.trim();

//     if (code == _verificationCode) {
//       User? user = await _checkUserExists(email);

//       if (user == null) {
//         await _registerUser(email);
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Verification code is incorrect.')),
//       );
//     }
//   }

//   Future<void> _sendVerificationCode() async {
//     String email = emailController.text.trim();
//     _verificationCode = emailService.generateVerificationCode();

//     print('Send Verification Code button clicked');
//     print('Verification code: $_verificationCode');

//     await emailService.sendVerificationCode(email, _verificationCode!);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Verification code sent to $email.')),
//     );
//   }

//   Future<User?> _loginWithEmailPassword(String email) async {
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: 'temporaryPassword',
//       );
//       return userCredential.user;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _registerUser(String email) async {
//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: 'temporaryPassword',
//       );
//       await FirebaseFirestore.instance
//           .collection('user')
//           .doc(userCredential.user?.uid)
//           .set({
//         'email': email,
//       });
//     } catch (e) {
//       print('Error registering user: $e');
//     }
//   }



//   // String? _verificationCode;
//   // bool isSignIn = false;

//   // void _signInWithEmailCode() async {
   

//   //   setState(() {
//   //     isSignIn = true;
//   //   });

//   //   try{
//   //     await emailService.sendCodeToEmail(
//   //       emailController.text.trim(), 
//   //       // passwordController.text.trim(),
//   //     );
//   //     Navigator.pushReplacement(
//   //       context, 
//   //       MaterialPageRoute(builder: (context) => HomePage()),
//   //     );
//   //   } catch (e) {
//   //     print("Error signing in: $e");
//   //   } finally{
//   //     setState(() {
//   //       isSignIn = false;
//   //     });
//   //   }
//   // }

//   //   void _signInWithEmailAndPassword() async {
//   //   try {
//   //     await authService.signInWithEmailPassword(
//   //       emailController.text.trim(),
//   //       passwordController.text.trim(),
//   //     );

//   //     User? user = authService.getCurrentUser();
//   //     if (user != null && user.emailVerified) {
//   //       Example: Navigator.pushReplacement(
//   //         context, MaterialPageRoute(builder: (context) => HomePage()),
//   //       );
//   //     } else {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Please verify your email first.')),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     String errorMessage = authService.getErrorMessage(e.toString());
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text(errorMessage)),
//   //     );
//   //   }
//   // }

//   // void _registerWithEmailAndPassword() async {
//   //   try {
//   //     await authService.signUpWithEmailPassword(
//   //       emailController.text.trim(),
//   //       passwordController.text.trim(),
//   //     );

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Registration successful. Please check your email for verification.')),
//   //     );

//   //   } catch (e) {
//   //     String errorMessage = authService.getErrorMessage(e.toString());
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text(errorMessage)),
//   //     );
//   //   }
//   // }

//   // void _sendVerificationEmail() async {
//   //   try {
//   //     await authService.sendEmailVerification();
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Verification email sent. Please check your inbox.')),
//   //     );
//   //   } catch (e) {
//   //     print('Error sending verification email: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to send verification email. Please try again later.')),
//   //     );
//   //   }
//   // }

  

// Widget build(BuildContext context) {
//          return Scaffold(
//        appBar: AppBar(title: Text('Login')),
//        body: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: Column(
//            children: [
//              TextField(
//                controller: emailController,
//                decoration: InputDecoration(labelText: 'Email'),
//              ),
//              ElevatedButton(
//                onPressed: _sendVerificationCode,
//                child: Text('Send Verification Code'),
//              ),
//              TextField(
//                controller: codeController,
//                decoration: InputDecoration(labelText: 'Verification Code'),
//              ),
//              ElevatedButton(
//                onPressed: signInWithEmailCode,
//                child: Text('Verify and Sign In'),
//              ),
//            ],
//          ),
//        ),
//      );
//    }
// }


// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColor,
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Padding(
// //               padding: EdgeInsets.all(25),
// //               child: Image.asset("lib/images/espresso.png", height: 100),
// //             ),
// //             SizedBox(height: 20),
// //             Text("Hi, Welcome",
// //               style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown[800], fontSize: 24),
// //             ),
// //             Text("Enter your email or phone number to enter",
// //               style: TextStyle(color: Colors.brown, fontSize: 16),
// //             ),
// //             SizedBox(height: 16),
// //             TextField(
// //               controller: emailController,
// //               decoration: InputDecoration(
// //                 labelText: "Email",
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             MyButton(text: "Send me verification code", onTap: _sendVerificationCode),
// //             // TextField(
// //             //   controller: passwordController,
// //             //   obscureText: true,
// //             //   decoration: InputDecoration(
// //             //     labelText: "Password",
// //             //   ),
// //             // ),  
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }














import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/email_service.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  final EmailService _emailService = new EmailService();

  String? _verificationCode;

  void signInWithEmailCode() async {
    String email = _emailController.text.trim();
    String code = _codeController.text.trim();

    if (code == _verificationCode) {
      User? user = await _checkUserExists(email);

      if (user == null) {
        await _registerUser(email);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification code is incorrect.')),
      );
    }
  }

  Future<void> _sendVerificationCode() async {
    String email = _emailController.text.trim();
    _verificationCode = _emailService.generateVerificationCode();

    print('Send Verification Code button clicked');
    print('Verification code: $_verificationCode');

    await _emailService.sendVerificationEmail(email, _verificationCode!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification code sent to $email.')),
    );
  }

  Future<User?> _checkUserExists(String email) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: 'temporaryPassword',
      );
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<void> _registerUser(String email) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: 'temporaryPassword',
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
      });
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: backgroundColor,
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.all(25),
  //             child: Image.asset("lib/images/latte.png", height: 140),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             "היי, ברוכים הבאים",
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               color: Colors.brown[800],
  //               fontSize: 26,
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             "הזינו את מספר הטלפון או המייל על מנת להיכנס",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 18,
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           ToggleButtons(
  //             children: <Widget>[
  //               Padding(
  //                 padding: EdgeInsets.all(5),
  //                 Text("טלפון"),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.all(5),
  //                 Text("מייל"),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

   Widget build(BuildContext context) {
         return Scaffold(
       appBar: AppBar(title: Text('Login')),
       body: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           children: [
             TextField(
               controller: _emailController,
               decoration: InputDecoration(labelText: 'Email'),
             ),
             ElevatedButton(
               onPressed: _sendVerificationCode,
               child: Text('Send Verification Code'),
             ),
             TextField(
               controller: _codeController,
               decoration: InputDecoration(labelText: 'Verification Code'),
             ),
             ElevatedButton(
               onPressed: signInWithEmailCode,
               child: Text('Verify and Sign In'),
             ),
           ],
         ),
       ),
     );
   }
}
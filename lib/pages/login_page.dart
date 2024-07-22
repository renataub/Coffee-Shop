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

  


// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coffee_shop/pages/home_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import '../services/email_service.dart';

// class LoginPage extends StatefulWidget {
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _codeController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   String? _verificationCode;
//   final EmailService _emailService = new EmailService();

  

//   void signInWithEmailCode() async {
//     String email = _emailController.text.trim();
//     String code = _codeController.text.trim();

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
//     String email = _emailController.text.trim();
//     _verificationCode = _emailService.generateVerificationCode();

//     print('Send Verification Code button clicked');
//     print('Verification code: $_verificationCode');

//     await _emailService.sendVerificationEmail(email, _verificationCode!);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Verification code sent to $email.')),
//     );
//   }

//   Future<User?> _checkUserExists(String email) async {
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

 
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/my_button.dart';
import '../const.dart';
import '../services/email_service.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _verificationCode;
  bool _isCodeSent = false;
  bool _isEmailSelected = false;
  final EmailService _emailService = new EmailService();

    void _verifyPhoneNumber() async{
    String phoneNumber = _phoneController.text.trim();

    if(!phoneNumber.startsWith("+")){
      phoneNumber = "+972" + phoneNumber;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await FirebaseAuth.instance.signInWithCredential(credential);
        _checkUserExists(phoneNumber);
      }, 
      verificationFailed: (FirebaseAuthException e){
        print("Verification Failed: ${e.message}");
      }, 
      codeSent: (String verificationCode, int? resendToken){
        setState(() {
          _verificationCode = verificationCode;
          _isCodeSent = true;
        });
      }, 
      codeAutoRetrievalTimeout: (String verificationId){}
    );
  }

  void _signInWithEmailCode() async {
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
        SnackBar(content: Text('Invalid Code'), backgroundColor: Colors.red,),
        
      );
    }
  }

  Future<void> _registerUser(String email) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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

  String _generateVerificationCode() {
    final random = Random();
    return List<int>.generate(6, (index) => random.nextInt(10)).join();
  }

  Future<void> _sendVerificationCode() async {
    String email = _emailController.text.trim();
    if(email.isEmpty || !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid email address"),
        backgroundColor: Colors.red,
      ));
      return ;
    }
    String verificationCode = _generateVerificationCode();
    await _emailService.sendVerificationEmail(email, verificationCode);
    setState(() {
      _verificationCode = verificationCode;
      _isCodeSent = true;
    });
  }

  void _signInSMSCode() async{
    if(_verificationCode != null){
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationCode!, 
        smsCode: _codeController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // _checkUserExists();
    }
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

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/images/latte.png", height: 100),
              SizedBox(height: 24),
              Text("Hi, Welcome!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              SizedBox(height: 8),
              Text("Enter email or phone number to enter"),
              SizedBox(height: 16),
              ToggleButtons(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("phone",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("email",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ], 
                isSelected: [_isEmailSelected == false, _isEmailSelected == true],
                onPressed: (index) {
                  setState(() {
                    _isEmailSelected = index == 1;
                    _isCodeSent = false;
                  });
                },
                borderColor: Colors.brown,
                borderRadius: BorderRadius.circular(8),
                fillColor: Colors.brown.shade200,
              ),
              SizedBox(height: 16),
              if(!_isEmailSelected) ...[
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "phone number",
                    prefixText: "+972",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ] else ...[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
              SizedBox(height: 16),
              if(!_isCodeSent) ...[
                MyButton(
                  text: _isEmailSelected ? "send me verification code in email" : "send me verification code", 
                  onTap: _isEmailSelected ? _sendVerificationCode :_verifyPhoneNumber,
                ),
              ] else ...[
                Text(_isEmailSelected ? "we sent verification code to your email" : "we sent verification code to your phone",
                  style: TextStyle(color: Colors.brown),
                ),
                SizedBox(height: 8),
                Text(_isEmailSelected ? _emailController.text : _phoneController.text,
                  style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    label: Text("Verification Code"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                MyButton(text: "Verify", onTap: _isEmailSelected ? _signInWithEmailCode : _signInSMSCode),
              ],
            ],
          ),
        ),
      ),
    );
  }

}
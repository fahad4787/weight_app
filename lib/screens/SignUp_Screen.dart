import 'package:char_yaar_trade/widgets/sigup_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'WeightOverView.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _submitAuthform(
    String email,
    String password,
    String name,
  ) async {
    // ignore: unused_local_variable
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushNamed(context, WeightOverView.routeName);
    } on FirebaseAuthException catch (error) {
      var messsage = 'An Error occured, please check your credential';
      if (error.message != null) {
        messsage = error.message!;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(messsage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(40),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(
                              color: Colors.indigo,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Signup to',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(
                              color: Colors.indigo,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'get started',
                        style: GoogleFonts.satisfy(
                          textStyle: TextStyle(
                              color: Colors.indigo,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SignUpForm(
                        _submitAuthform,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

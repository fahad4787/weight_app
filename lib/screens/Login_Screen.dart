import 'package:char_yaar_trade/widgets/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void _submitAuthform(
    String email,
    String password,
  ) async {
    // ignore: unused_local_variable
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      var messsage = 'An Error occured, please check your credential';
      if (error.message != null) {
        messsage = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(messsage),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 120),
            padding: EdgeInsets.all(16),
            child: Column(children: [
              Text(
                'Here To Get',
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      color: Colors.indigo,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Welcomed!',
                style: GoogleFonts.lobster(
                  textStyle: TextStyle(
                      color: Colors.indigo,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: LoginForm(
                  _submitAuthform,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

import 'package:char_yaar_trade/screens/WeightOverView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(this.submitfn);

  final void Function(
    String email,
    String password,
    String name,
  ) submitfn;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _submit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState!.save();
      widget.submitfn(_userEmail, _userPassword, _userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'please Enter Your Name';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Name'),
            onSaved: (value) {
              _userName = value!;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Enter a valid Email';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              _userEmail = value!;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return 'password is too short';
              }
              return null;
            },
            decoration: InputDecoration(labelText: 'Password'),
            onSaved: (value) {
              _userPassword = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sigup',
                style: GoogleFonts.abrilFatface(
                  textStyle: TextStyle(
                      color: Colors.indigo,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: _submit,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Already have an account?',
                style: GoogleFonts.abrilFatface(
                  textStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.abrilFatface(
                      textStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

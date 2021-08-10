import 'package:char_yaar_trade/screens/SignUp_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.submitfn);

  final void Function(
    String email,
    String password,
  ) submitfn;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userPassword = '';

  void _submit() {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formkey.currentState!.save();
      widget.submitfn(
        _userEmail,
        _userPassword,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          // ignore: deprecated_member_use
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Login',
                style: GoogleFonts.abrilFatface(
                  textStyle: TextStyle(
                      fontSize: 40, color: Theme.of(context).primaryColor),
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
                // ignore: deprecated_member_use
                child: Text(
                  'Dont have an Account?',
                  style: GoogleFonts.abrilFatface(
                    textStyle: TextStyle(color: Theme.of(context).primaryColor),
                  ),
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
                    Navigator.of(context).pushNamed(SignUp.routeName);
                  },
                  child: Text(
                    'Sign up',
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

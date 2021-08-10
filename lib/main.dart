import 'package:char_yaar_trade/screens/Login_Screen.dart';
import 'package:char_yaar_trade/screens/WeightOverView.dart';
import 'package:char_yaar_trade/screens/SignUp_Screen.dart';
import 'package:char_yaar_trade/screens/Add_New_Weight_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.lightBlue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapShot.hasData) {
            return WeightOverView();
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.routName: (ctx) => LoginScreen(),
        SignUp.routeName: (ctx) => SignUp(),
        NewWeightInfo.routeName: (ctx) => NewWeightInfo(),
        WeightOverView.routeName: (ctx) => WeightOverView(),
      },
    );
  }
}

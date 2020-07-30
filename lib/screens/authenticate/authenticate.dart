import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/authenticate/register.dart';
import 'package:flutter_firebase/screens/authenticate/sign_in.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toogle(){
    return setState(() {
    showSignIn=!showSignIn;
  });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    return Register(toogle);
    else return Signin(toogle);
  }
}
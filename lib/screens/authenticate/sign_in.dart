import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constant.dart';
import 'package:flutter_firebase/shared/loading.dart';

class Signin extends StatefulWidget {
  final Function toogle;

  Signin(this.toogle);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey= GlobalKey<FormState>();
  bool loading=false;
  final Authservice authservice=Authservice();
  String email="",password="",error="";
  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign in into Brew Crew'),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toogle();
          }, icon: Icon(Icons.person), label: Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40,),
              TextFormField(
                decoration: inputdecoration.copyWith(hintText: "Email"),
                validator: (val){
                  if(val.isEmpty){
                    return "please fill the email";
                  }
                  else return null;
                },
                onChanged: (val){
                  setState(() {
                    email=val;

                  });
                },
              ),
              SizedBox(height: 40,),
              TextFormField(
                decoration: inputdecoration.copyWith(hintText: "Password"),
                validator:(value){
                  if(value.length<6){
                    return "password is short";
                  }
                  return null;
                },
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
                obscureText: true,
              ),SizedBox(height: 40,),
              RaisedButton(
                color: Colors.pink[200],
                onPressed:  () async {
                  if(_formkey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });

                   dynamic result=authservice.signInwithEmailandPassword(email, password);
                   if(result==null){
                     setState(() {
                       loading=false;
                       error="User is not exists";
                     });

                   }
                  }
                },
                child: Text('Sign In',
                style: TextStyle(
                  color: Colors.white
                ),),

              ),
              SizedBox(height: 20,),
              Text(error,
              style: TextStyle(
                color: Colors.red,

              ),)
            ],
          ),
        ),
      ),
    );
  }
}


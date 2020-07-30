import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constant.dart';
import 'package:flutter_firebase/shared/loading.dart';
class Register extends StatefulWidget {
  final Function toogle;

  Register(this.toogle);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading =false;
  final _formkey= GlobalKey<FormState>();
  final Authservice authservice=Authservice();
  String email="",password="",error='';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign in into Brew Crew'),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toogle();
          }, icon: Icon(Icons.person), label: Text("Login"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: Form(
          key:_formkey,
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
                onPressed: () async {
                  if(_formkey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                  dynamic result=await authservice.registerwithEmailandPassword(email, password);
                    if(result==null){
                      setState(() {
                        error='please enter the valid email';

                      });
                    }
                    else{

                    }
                  }

                },
                child: Text('Register',
                  style: TextStyle(
                      color: Colors.white
                  ),),

              ),
              SizedBox(height: 20,),
                Text(error,
                  style: TextStyle(
                      color: Colors.red,)),

            ],
          ),
        ),
      ),
    );;
  }
}

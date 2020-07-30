
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/screens/Home/setting_form.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import '';
import 'brewList.dart';
class Home extends StatelessWidget {
  Authservice authservice=Authservice();
  
  @override
  Widget build(BuildContext context) {
    void _showSettingpanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: Settingsform(),
        );
      });
    }
    return StreamProvider<List<Brew>>.value(
      value:new DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew crew"),
          backgroundColor: Colors.brown[400],
          elevation: 2,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await authservice.signout();

            }, icon: Icon(Icons.person), label: Text("logout")),
            FlatButton.icon(onPressed: ()=> _showSettingpanel(),
                icon: Icon(Icons.settings), label: Text("Setting")),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage("https://raw.githubusercontent.com/iamshaunjp/flutter-firebase/lesson-27/brew_crew/assets/coffee_bg.png")
            )

          ),
            child: BrewList()),

      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://raw.githubusercontent.com/iamshaunjp/flutter-firebase/lesson-27/brew_crew/assets/coffee_icon.png"),
              radius: 25.0,
              backgroundColor: Colors.brown[brew.strength],
            ),
            title: Text(brew.name,
            style: TextStyle(

            ),),
            subtitle: Text("Take ${brew.sugars} sugar(s)"),
          ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';
class Authservice{
  //sign in anon
  User userfromfirebaseuser(FirebaseUser user){
  return user!=null ? User(user.uid):null;
  }
  //returning our own custom user into stream
  Stream<User> get user{
    return firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => userfromfirebaseuser(user));
  }

 final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
 Future signinAnon() async{
   try{
     AuthResult authResult=await firebaseAuth.signInAnonymously();
     FirebaseUser user=authResult.user;
     return userfromfirebaseuser(user);
   }
   catch(e){
     return null;

   }
 }
 //logout
Future signout () async{
   try{
  return await firebaseAuth.signOut();
   }
   catch(e){
  print(e.toString());
      return null;
   }

}

  //signin email and password
  Future signInwithEmailandPassword(String email,String password) async
  {
    try {
      AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return userfromfirebaseuser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register email and password
Future registerwithEmailandPassword(String email,String password) async
{        
  try{
   AuthResult authResult=await  firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser user=authResult.user;
       await DatabaseService(uid: user.uid).updateUserData("0", "new crew member", 100);
      return userfromfirebaseuser(user);
  }
  catch(e){
    print(e.toString());
    return null;
  }
  
}
}
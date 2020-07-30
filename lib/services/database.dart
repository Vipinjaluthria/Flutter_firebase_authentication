import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/Home/brewList.dart';
class DatabaseService {
  //collection reference

  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewcollections = Firestore.instance.collection(
      'brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewcollections.document(uid).setData({
      "name": name,
      "sugars": sugars,
      "strength": strength,
      "timestamp":FieldValue.serverTimestamp(),
    });
  }
  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
           return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }
  //UserData
  UserData _userDatafromsnapshot(DocumentSnapshot documentSnapshot){
    return UserData(
      uid: uid,
      name: documentSnapshot.data['name'],
      strength: documentSnapshot.data['strength'],
      sugars: documentSnapshot.data['sugars'],
    );


}

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewcollections.snapshots()
        .map(_brewListFromSnapshot);
  }
  Stream<UserData> get userData{
    return brewcollections.document(uid).snapshots()
        .map((DocumentSnapshot documentSnapshot) => _userDatafromsnapshot(documentSnapshot));
  }

}

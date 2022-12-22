import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String firstName;
  String secondName;
  DocumentReference reference;

  UserModel({this.uid, this.email, this.firstName, this.secondName});



  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }

  
  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMaped(snapshot.data.call(), reference: snapshot.reference);

  UserModel.fromMaped(Map<String, dynamic> map, {this.reference})
      : email = map['email'],
        firstName = map['firstName'],
        secondName = map['secondName'],
        uid = map['uid'];
}
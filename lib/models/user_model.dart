import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String mobileNumber;
  final String photoName;
  final DocumentReference reference;

  User({
    this.name,
    this.id,
    this.email,
    this.reference,
    this.photoUrl,
    this.mobileNumber,
    this.photoName,
  });

  User.fromMap(Map map, {this.reference})
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        photoUrl = map['photoUrl'],
        mobileNumber = map['mobileNumber'],
        photoName = map['photoName'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "mobileNumber": mobileNumber,
        "photoName": photoName,
      };

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}

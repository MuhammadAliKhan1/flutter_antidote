import 'package:antidote/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Therapist {
  final String id;
  final String name;
  final String email;
  final String photoUrl;
  final String mobileNumber;
  final String photoName;
  final double rating;
  final String password;
  final DocumentReference reference;

  Therapist({
    this.password,
    this.name,
    this.id,
    this.email,
    this.reference,
    this.photoUrl,
    this.mobileNumber,
    this.photoName,
    this.rating,
  });

  Therapist.fromMap(Map map, {this.reference})
      : id = map['id'] ?? null,
        name = map['name'] ?? null,
        email = map['email'] ?? null,
        photoUrl = map['photoUrl'] ?? null,
        mobileNumber = map['mobileNumber'] ?? null,
        photoName = map['photoName'] ?? null,
        password = map['password'] ?? null,
        rating = map['rating'] ?? 0;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "mobileNumber": mobileNumber.toString(),
        "photoName": photoName,
        "rating": rating,
        "password": password,
      };

  Therapist.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

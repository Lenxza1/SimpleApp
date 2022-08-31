import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photourl;
  final String username;
  final String name;
  final List followers;
  final List following;

  const User(
      {required this.email,
      required this.uid,
      required this.photourl,
      required this.username,
      required this.name,
      required this.followers,
      required this.following});

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'photoUrl': photourl,
        'username': username,
        'name': name,
        'followers': followers,
        'following': following
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        email: snapshot['email'],
        uid: snapshot['uid'],
        photourl: snapshot['photourl'],
        username: snapshot['username'],
        name: snapshot['name'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }
}

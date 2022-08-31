// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String content;
  final String uid;
  final datePublished;
  final String username;
  final String postId;
  final String postUrl;
  final String profImage;
  final likes;

  const Post(
      {required this.content,
      required this.uid,
      required this.datePublished,
      required this.username,
      required this.postId,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'content': content,
        'uid': uid,
        'posturl': postUrl,
        'username': username,
        'postId': postId,
        'datePublished': datePublished,
        'profImage': profImage,
        'likes': likes
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
        content: snapshot['content'],
        uid: snapshot['uid'],
        postUrl: snapshot['posturl'],
        username: snapshot['username'],
        postId: snapshot['postId'],
        datePublished: snapshot['datePublished'],
        profImage: snapshot['profImage'],
        likes: snapshot['likes']);
  }
}

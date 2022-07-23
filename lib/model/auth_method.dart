import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_app/model/storage_method.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signUpUser(
      {required String email,
      required String password,
      required String username,
      required String name,
      required Uint8List file}) async {
    String res = 'Ada error yang terjadi';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          name.isNotEmpty) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photourl =
            await StorageMethods().uploadImage('profilePics', file, false);
        await firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'uid': credential.user!.uid,
          'email': email,
          'name': name,
          'followers': [],
          'following': [],
          'photourl': photourl
        });

        return res = 'Success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email yang dimasukan tidak valid';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email yang dimasukan sudah dipakai';
      } else if (err.code == 'weak-password') {
        res = 'Password Terlalu lemah, Password minimal adalah 6 karakter';
      }
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = 'Some Error Occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        res = 'Success';
      } else {
        res = 'Tolong isi seluruh kolom';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'wrong-password') {
        res = 'Password Salah';
      } else if (err.code == 'invalid-email') {
        res = 'Email Salah';
      } else if (err.code == 'user-disabled') {
        res = 'Akun telah dinonaktifkan. Harap hubungi administrator';
      } else if (err.code == 'user-not-found') {
        res = 'Tidak ada akun yang terdaftar dengan email tersebut';
      }
    }
    return res;
  }
}

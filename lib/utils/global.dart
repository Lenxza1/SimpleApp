import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_app/screens/add_post_screens.dart';
import 'package:simple_app/screens/home_screeens.dart';
import 'package:simple_app/screens/profile_screen.dart';
import 'package:simple_app/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const HomeScreens(),
  const SearchScreen(),
  const AddPostScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

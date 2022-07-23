import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_app/responsive/responsive_layout_screen.dart';
import 'package:simple_app/responsive/web.dart';
import 'package:simple_app/screens/home_screeens.dart';
import 'package:simple_app/screens/login_screens.dart';
import 'package:simple_app/screens/signup_screens.dart';
import 'package:simple_app/utils/app_style.dart';
import 'package:simple_app/utils/colors.dart';

import 'responsive/mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCBDocVu41cnp2MZ16TMf3ERwukP7eW3ZQ",
            authDomain: "simpleapp-2e143.firebaseapp.com",
            projectId: "simpleapp-2e143",
            storageBucket: "simpleapp-2e143.appspot.com",
            messagingSenderId: "748141922390",
            appId: "1:748141922390:web:2769999fa2a361bb8993f7",
            measurementId: "G-ZEMNDDX5C5"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/Login': (context) => const LoginScreen(),
        '/SignUp': (context) => const SignupScreen(),
        '/Home': (context) => const HomeScreens()
      },
      debugShowCheckedModeBanner: false,
      title: 'Simple App',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobileScreenLayout());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Ada sebuah error yang terjadi pada sistem",
                  style: appStyle.titleStyle,
                ),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const LoginScreen();
        }));
  }
}

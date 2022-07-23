// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_app/model/auth_method.dart';
import 'package:simple_app/utils/app_style.dart';
import 'package:simple_app/utils/colors.dart';
import 'package:simple_app/utils/utils.dart';
import 'package:simple_app/widget/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailTextController.text,
        password: _passwordTextController.text);

    if (res != 'Success') {
      showSnackBar(context, res);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              TextFieldInput(
                  textEditingController: _emailTextController,
                  hintText: 'Masukan Email Anda',
                  inputType: TextInputType.emailAddress),
              const SizedBox(height: 5),
              TextFieldInput(
                  textEditingController: _passwordTextController,
                  hintText: 'Masukan Password Anda',
                  inputType: TextInputType.text,
                  isPass: true),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                  child: Text(
                    'Login',
                    style: appStyle.contentStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(flex: 2, child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Belum Punya akun?',
                      style: appStyle.contentStyle,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/SignUp');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.bodoniModa(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: blueColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

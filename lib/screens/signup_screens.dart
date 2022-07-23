import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_app/model/auth_method.dart';
import 'package:simple_app/utils/app_style.dart';
import 'package:simple_app/utils/colors.dart';
import 'package:simple_app/utils/utils.dart';
import 'package:simple_app/widget/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _bioTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _bioTextController.dispose();
    _usernameTextController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods()
        .signUpUser(
            email: _emailTextController.text,
            password: _passwordTextController.text,
            username: _usernameTextController.text,
            name: _bioTextController.text,
            file: _image!)
        .whenComplete(() => Navigator.pop(context));
    if (res != 'Success') {
      // ignore: use_build_context_synchronously
      showSnackBar(context, res);
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
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://www.nicepng.com/png/detail/933-9332131_profile-picture-default-png.png"),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldInput(
                  textEditingController: _emailTextController,
                  hintText: 'Masukan Email Anda',
                  inputType: TextInputType.emailAddress),
              const SizedBox(height: 6),
              TextFieldInput(
                  textEditingController: _passwordTextController,
                  hintText: 'Masukan Password Anda',
                  inputType: TextInputType.text,
                  isPass: true),
              const SizedBox(height: 6),
              TextFieldInput(
                  textEditingController: _usernameTextController,
                  hintText: 'Masukan Username Anda',
                  inputType: TextInputType.text),
              const SizedBox(height: 6),
              TextFieldInput(
                  textEditingController: _bioTextController,
                  hintText: 'Masukan Nama Anda',
                  inputType: TextInputType.text),
              const SizedBox(height: 6),
              const SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {},
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
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
                          'Sign Up',
                          style: appStyle.contentStyle,
                        ),
                      ),
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

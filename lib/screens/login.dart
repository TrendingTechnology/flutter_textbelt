import 'package:flutter/material.dart';
import 'package:flutter_textbelt/screens/otp.dart';
import 'package:flutter_textbelt/widgets/main_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'code_generator.dart';
import 'google_home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn _googleSignIN = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Authenticator',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            MainButtons(
              label: "With Google",
              onPress: () {
                _googleSignIN.signIn().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => GoogleHome(
                                user: value!,
                              )));
                });
              },
              icon: const Icon(Icons.login),
            ),
            const SizedBox(
              height: 15,
            ),
            MainButtons(
              label: "With OTP",
              onPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => const OTP()));
              },
              icon: const Icon(Icons.phone),
            ),
            const SizedBox(
              height: 15,
            ),
            MainButtons(
                label: "With Code",
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const CodeGenerator()));
                },
                icon: const Icon(Icons.code_rounded))
          ],
        ),
      )),
    );
  }
}

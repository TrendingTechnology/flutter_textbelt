import 'package:flutter/material.dart';
import 'package:flutter_textbelt/screens/otp.dart';
import 'package:flutter_textbelt/widgets/mainButtons.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'codeGenerator.dart';
import 'googleHome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignIn _googleSignIN = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Authenticator',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
              icon: Icon(Icons.login),
            ),
            SizedBox(
              height: 15,
            ),
            MainButtons(
              label: "With OTP",
              onPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => OTP()));
              },
              icon: Icon(Icons.phone),
            ),
            SizedBox(
              height: 15,
            ),
            MainButtons(
                label: "With Code",
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CodeGenerator()));
                },
                icon: Icon(Icons.code_rounded))
          ],
        ),
      )),
    );
  }
}

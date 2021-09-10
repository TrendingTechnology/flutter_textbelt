import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleHome extends StatelessWidget {
  final GoogleSignInAccount user;
  const GoogleHome({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Google User",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(user.displayName!),
              const SizedBox(
                height: 20,
              ),
              Text(user.email),
              const SizedBox(
                height: 20,
              ),
              Image.network(user.photoUrl!),
              const SizedBox(
                height: 190,
              )
            ],
          ),
        ));
  }
}

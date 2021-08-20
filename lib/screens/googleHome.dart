import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleHome extends StatelessWidget {
  final GoogleSignInAccount user;
  const GoogleHome({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Google User",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(user.displayName!),
                SizedBox(
                  height: 20,
                ),
                Text(user.email),
                SizedBox(
                  height: 20,
                ),
                Image.network(user.photoUrl!),
                SizedBox(
                  height: 190,
                )
              ],
            ),
          ),
        ));
  }
}

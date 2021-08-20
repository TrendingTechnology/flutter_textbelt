import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CodeGenerator extends StatefulWidget {
  const CodeGenerator({Key? key}) : super(key: key);

  @override
  _CodeGeneratorState createState() => _CodeGeneratorState();
}

class _CodeGeneratorState extends State<CodeGenerator> {
  Timer? x;
  var _secretCode = 0;
  int currentTimer = 30;
  String currentTimerToDisplay = "";
  void timer() {
    x = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (mounted) {
        currentTimerToDisplay =
            (currentTimer < 10 ? "0" : "").toString() + currentTimer.toString();
        if (currentTimer >= 0) currentTimer = currentTimer - 1;
        if (currentTimer < 0) {
          _secretCode = Random().nextInt(99999999);
          currentTimer = 30;
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    timer();
    setState(() {
      _secretCode = Random().nextInt(99999999);
    });
  }

  @override
  void dispose() {
    super.dispose();
    x?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Authenticate with Code",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _secretCode.toString(),
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                currentTimerToDisplay,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

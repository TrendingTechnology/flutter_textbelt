import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../api/textbelt.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final _mobController = TextEditingController();
  final _otpController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  final BoxDecoration _pinPutDecoration = BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(5.0),
  );

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(Random().nextInt(_chars.length))));
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  String _userId = "";
  bool _isButton = false;
  bool _insertOtp = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userId = getRandomString(15);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Authenticate with Mobile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _insertOtp
                  ? PinPut(
                      autofocus: _insertOtp,
                      withCursor: true,
                      fieldsCount: 6,
                      onChanged: (val) {
                        setState(() {
                          if (val.length > 5) {
                            _isButton = true;
                          } else {
                            _isButton = false;
                          }
                        });
                      },
                      fieldsAlignment: MainAxisAlignment.spaceAround,
                      focusNode: _pinPutFocusNode,
                      textStyle:
                          const TextStyle(fontSize: 25.0, color: Colors.white),
                      eachFieldMargin: const EdgeInsets.all(0),
                      eachFieldWidth: 45.0,
                      eachFieldHeight: 55.0,
                      controller: _otpController,
                      submittedFieldDecoration: _pinPutDecoration,
                      selectedFieldDecoration: _pinPutDecoration.copyWith(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.number,
                      followingFieldDecoration: _pinPutDecoration,
                      pinAnimationType: PinAnimationType.scale,
                    )
                  : TextFormField(
                      autofocus: !_insertOtp,
                      controller: _mobController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: const TextStyle(fontSize: 25),
                      onChanged: (val) {
                        setState(() {
                          if (val.length > 9) {
                            _isButton = true;
                          } else {
                            _isButton = false;
                          }
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        prefix: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text("+91"),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 200, 200, 200),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _isButton
                    ? _insertOtp
                        ? () {
                            setState(() {
                              _isLoading = true;
                            });
                            TextBelt.veriOtp(
                                    otp: _otpController.text,
                                    userId: _userId,
                                    key: dotenv.env["key"]!)
                                .then((value) {
                              if (value["success"]) {
                                _isButton = false;
                                _insertOtp = false;
                                Fluttertoast.showToast(
                                    msg: "You are Good to Go");
                              } else {
                                Fluttertoast.showToast(
                                    msg: "${value["isValidOtp"]} Try again!");
                              }
                            });
                            _otpController.text = "";
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        : () {
                            setState(() {
                              _isLoading = true;
                            });
                            TextBelt.sendOTP(
                                    phone: _mobController.text,
                                    key: dotenv.env["key"]!,
                                    userId: _userId)
                                .then((value) {
                              if (value["success"]) {
                                _insertOtp = true;
                                Fluttertoast.showToast(msg: "Otp Sent");
                              } else {
                                Fluttertoast.showToast(
                                    msg: "${value["msg"]} Try again!");
                              }
                            });
                            _mobController.text = "";
                            setState(() {
                              _isButton = false;
                              _isLoading = false;
                            });
                          }
                    : null,
                style: ButtonStyle(
                  padding: _isLoading
                      ? MaterialStateProperty.all(const EdgeInsets.all(25))
                      : MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 5)),
                  backgroundColor: _isButton
                      ? MaterialStateProperty.all(
                          Colors.lightBlue,
                        )
                      : MaterialStateProperty.all(
                          const Color.fromARGB(125, 225, 225, 225),
                        ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        _insertOtp ? "Verify OTP" : "Send OTP",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

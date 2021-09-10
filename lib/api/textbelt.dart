import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class TextBelt {
  static sendOTP({
    required String phone,
    required String userId,
    required String key,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('https://textbelt.com/otp/generate'),
        headers: {"Accept": "application/json"},
        body: {
          "phone": phone,
          "userid": userId,
          "key": key,
        },
      );
      // {"success": true, "textId": "1234", "quotaRemaining": 70, "otp": "672383"}
      // {"success": false, "quotaRemaining": 0, "otp": ""}
      if (json.decode(response.body)["success"] == false) {
        return {"success": false, "msg": "Connection Error 😑"};
      }
      return json.decode(response.body);
    } on SocketException {
      return {"success": false, "msg": "No Internet connection 😑"};
    } catch (e) {
      return {"success": false, "msg": "Connection Error 😑"};
    }
  }

  static veriOtp({
    required String otp,
    required String userId,
    required String key,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(
            "https://textbelt.com/otp/verify?otp=$otp&userid=$userId&key=$key"),
        headers: {"Accept": "application/json"},
      );
      //  {"success": true, "isValidOtp": false}
      // {"success": true, "isValidOtp": true}
      if (json.decode(response.body)["isValidOtp"] == false) {
        return {"success": false, "isValidOtp": "Invalid OTP 😑"};
      }
      return json.decode(response.body);
    } on SocketException {
      return {"success": false, "isValidOtp": "No Internet connection 😑"};
    } catch (e) {
      return {"success": false, "isValidOtp": "Connection Error 😑"};
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:textapp/pages/Homepage.dart';
import 'dart:convert';
import 'package:textapp/servises/AuthManager.dart';



class ApiServiceLogin {

  static const String baseUrl = 'http://3.86.243.195:4000/login';

  Future<void> login(
      BuildContext context, String mobile, String password) async {
    final Map<String, dynamic> requestBody = {
      'mobile': mobile,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    print(response.statusCode);
    print(response.body);

  

    if (response.statusCode != 200) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops..',
          text:
              "Incorrect mobile number or password!"); // Update the error message
    } else {
      AuthManager.token = response.body; //store the token
      AuthManager.login(); //setting the logged in user true
      
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Great',
        text: 'Succesfully logged in',
        onConfirmBtnTap: () {
            Get.offAll(HomePage());
        
        },
      );
    }
  }
}

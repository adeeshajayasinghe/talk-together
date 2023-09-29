import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'dart:convert';

import 'package:textapp/models/item.dart';
import 'package:textapp/pages/logIn.dart';


class ApiService {
  static const String baseUrl = 'http://3.86.243.195:4000/register';

  Future<void> addItem(BuildContext context, Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );

    print(response.body);
    if (response.statusCode != 200) {
      Map<String, dynamic> errormessage =
          json.decode(response.body); //convert result string in to a Map
      // ignore: use_build_context_synchronously
      throw Exception(QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops..',
          text: errormessage["error"]));
    } else {
      
      print('Item added');
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Registered',
        text:
            "Successfully registered. Please login",
        onConfirmBtnTap: () {
          Get.off(LogIn());
        },
      );

      // ignore: use_build_context_synchronously
    }
  }
}

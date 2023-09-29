import 'dart:convert';

import 'package:http/http.dart' as http;

class Subcription {
  static const String baseUrl = "https://api.mspace.lk/subscription/send";

  Future<void> checkSubscription() async {
    final Map<String, dynamic> requestBody = {
      // "applicationId": "APP_008052",
      // "password": "9427dc08a34933a8b846e02148c63f5e",
      "subscriberId": "tel:94702868872",
      "action": "0"
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody), // Encode the map as JSON
    );

    print(response.statusCode);
    print(response.body);

  }
}

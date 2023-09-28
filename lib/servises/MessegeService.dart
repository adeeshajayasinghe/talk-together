import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:textapp/models/Countries.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
//import 'package:permission_handler/permission_handler.dart';


final List<Map<String, String>> messagesList = [];
String openAiKey = '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';

Future<void> chatGPTAPI(String prompt) async {
  messagesList.add({
    'role': 'user',
    'content': prompt,
  });

  try {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": messagesList,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print(responseBody);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }

  } catch (e) {
    print('Error: $e');
  }
}

// translator

Future<String> translater( {required messege,required fromL, required toL}) async {

  final translator = GoogleTranslator();
  final input = messege;
  final from = CountriesLanguageCodes[fromL];
  final to = CountriesLanguageCodes[toL];


  var translation = await translator
      .translate(input, from: '$from', to: '$to');

  print("translation: $translation");
  return translation.toString();
  // prints translation: Vorrei comprare una macchina, se avessi i soldi.
}



Future<String> getPhoneNumberByName(String contactName) async {
  const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');
  print(kIsWeb);
  // Request contacts permission if not granted


  if (!kIsWeb ) {
    print(kIsWeb);
    final contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withThumbnail: false,
    );
    final targetContact = contacts.firstWhere(
      (contact) => contact.displayName == contactName,
      orElse: () => Contact(),
    );

    if (targetContact != null) {
      return targetContact.phones.isNotEmpty
          ? targetContact.phones.first.number
          : 'Phone number not found';
    } else {
      return 'Contact not found';
    }
  } else {
    return 'Permission denied';
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:textapp/constants/constants.dart';
import 'package:textapp/pages/messege/showAlert.dart';
import 'package:textapp/servises/AuthManager.dart';
import 'dart:ui';
import '../../servises/MessegeService.dart';
import '../Homepage.dart';
import 'package:intl/intl.dart';


onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class Messege extends StatefulWidget {
  final String speakingSelectedLang;
  final String TranslatingSelectedLang;

  Messege(
      {required this.speakingSelectedLang,
      required this.TranslatingSelectedLang});

  @override
  _MessegeState createState() => _MessegeState();
}

class _MessegeState extends State<Messege> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool ismessegeEmpty = true;
  String translatedText = '';

  @override
  void initState() {
    super.initState();
    fetchMessages();
    phoneNumberController.addListener(() {
      fetchMessages();
    });
  }

  int clicked = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
         iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255), //change your color here
        ),
        title: const Text(
          'Messenger',
          style: TextStyle(color: kappBartitleColor),
        ),
        backgroundColor: Colors.black,
        actions: [
            if (AuthManager.isLoggedIn)
              TextButton(
                  onPressed: () {
                 
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  )),
            IconButton(
                onPressed: () {
                  Get.offAll(HomePage());
                },
                icon: const Icon(Icons.home_filled))
          ]
      ),
      body: Container(
        decoration: BoxDecoration(color: kbackgroundColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kborderColor),
                    borderRadius: BorderRadius.circular(50),
                    color: ktextAreaColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: phoneNumberController,
                    style: const TextStyle(
                      color: ktextColor,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter phone number',
                      hintStyle: TextStyle(color: ktextColor),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  SmsMessage message = messages[index];
                  return GestureDetector(
                    onTap: () async {
                      // Translate the message when clicked
                      String translatedMessage = await translater(
                        messege: message.body,
                        fromL: widget.speakingSelectedLang,
                        toL: widget.TranslatingSelectedLang,
                      );
                      setState(() {
                        clicked = index;

                        message.body = translatedMessage;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: message.subject == 'sent'
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: clicked == index
                                ? Color.fromARGB(255, 0, 0, 0)
                                : Color.fromARGB(255, 0, 47, 72),
                            borderRadius: message.subject == 'sent'
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  )
                                : const BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                            border: Border.all(color: kborderColor, width: 1),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  '${message.address}',
                                  style: TextStyle(color: ktextsenderColor),
                                ),
                                subtitle: Text(
                                  '${message.body}',
                                  style: TextStyle(color: ktextmessegeColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 12.0, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(message.date.toString()))),
                                      style:
                                          TextStyle(color: ktextmessegeColor),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: kborderColor,
                          ),
                          borderRadius: BorderRadius.circular(50),
                          color: ktextAreaColor),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: TextField(
                          style: TextStyle(color: ktextColor),
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: ktextColor),
                            hintText: 'Message',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: kbuttonColor,
                    onPressed: () async {
                      translatedText = '';
                      sendMessage(message: messageController.text);
                      messageController.clear();
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //functions-------------------------------------------------------------------

  Future<void> fetchMessages() async {
    try {
      String phoneNumber = phoneNumberController.text;
      SmsFilter filter;

      filter = SmsFilter.where(SmsColumn.ADDRESS)
          .like('%${phoneNumber}'); // fetch all '%'

      List<SmsMessage> inboxMessages =
          await telephony.getInboxSms(filter: filter);
      List<SmsMessage> sentMessages =
          await telephony.getSentSms(filter: filter);

      // Add a "received" tag to inboxMessages and a "sent" tag to sentMessages
      List<SmsMessage> taggedInboxMessages = inboxMessages.map((message) {
        message.subject = 'received';
        return message;
      }).toList();
      List<SmsMessage> taggedSentMessages = sentMessages.map((message) {
        message.subject = 'sent';
        return message;
      }).toList();

      setState(() {
        messages = [...taggedInboxMessages, ...taggedSentMessages];
      });
    } catch (e) {
      print("Error fetching and translating messages: $e");
    }
  }

  Future<void> sendMessage({required String message}) async {
    var address = phoneNumberController.text;
    if (address.isEmpty || message.isEmpty) {
      return;
    }
    try {
      listener(SendStatus status) {
        if (status == SendStatus.DELIVERED) {
          showStatusDialog(context, 'Message sent');
          ;
        }
      }

      translatedText = await translater(
        messege: messageController.text,
        fromL: widget.TranslatingSelectedLang,
        toL: widget.speakingSelectedLang,
      );
      telephony.sendSms(
          to: address, message: translatedText, statusListener: listener);
      // ignore: empty_catches
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}

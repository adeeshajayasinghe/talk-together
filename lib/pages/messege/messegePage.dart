
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:textapp/constants/constants.dart';
import 'package:textapp/pages/messege/showAlert.dart';
import 'dart:ui';
import 'MessegeService.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messenger',
          style: TextStyle(color: kappBartitleColor),
        ),
        backgroundColor: Colors.black,
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
                        message.body = translatedMessage;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        border: Border.all(color: kborderColor, width: 1),
                      ),
                      child: ListTile(
                        title: Text(
                          '${message.address}',
                          style: TextStyle(color: ktextsenderColor),
                        ),
                        subtitle: Text(
                          '${message.body}',
                          style: TextStyle(color: ktextmessegeColor),
                        ),
                      ),
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
                      sendMessage();
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
          .like('${phoneNumber}%'); // fetch all '%'

      List<SmsMessage> inboxMessages =
          await telephony.getInboxSms(filter: filter);

      setState(() {
        messages = inboxMessages;
      });
    } catch (e) {
      print("Error fetching and translating messages: $e");
    }
  }

  Future<void> sendMessage() async {
    var address = phoneNumberController.text;
    var message = messageController.text;
    if (address.isEmpty || message.isEmpty) {
      return;
    }
    try {
       

      listener(SendStatus status) {
      
        if (status == SendStatus.DELIVERED) {
          showStatusDialog(context, 'Message sent');;
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

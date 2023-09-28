import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textapp/pages/languageSelection.dart';

class SubscriptionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SubscriptionPage(),
    );
  }
}

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 21, 51),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
          child: Text(
            'Subscription Page',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {
            Get.to(const langugeSelection());
          },
        ),
      ),
      backgroundColor: Color.fromARGB(255, 4, 21, 51),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Add padding around the ListView
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 35),
            children: <Widget>[
              Text(
                'Choose a Subscription Plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              SizedBox(height: 20),
              SubscriptionButton('Daily Plan', '\$5'),
              SubscriptionButton('Monthly Plan', '\$50'),
              SubscriptionButton('Yearly Plan', '\$200'),
              SubscriptionButton('Lifetime Plan', '\$1000'),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionButton extends StatelessWidget {
  final String title;
  final String price;

  SubscriptionButton(this.title, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0), // Add padding around the button
      margin: EdgeInsets.symmetric(vertical: 2),
      child: ElevatedButton(
        onPressed: () {
          Get.to(const langugeSelection());
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 3, 40, 141),
          onPrimary: Colors.white,
          padding: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 7, 238, 255),
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


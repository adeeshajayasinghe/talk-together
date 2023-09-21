import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final TextEditingController inputController;
  final String title;
  final Widget icon;
  final bool hide;
  const Inputs(
      {super.key,
      required this.inputController,
      required this.title,
      required this.icon,
      required this.hide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: hide,
              textAlignVertical: TextAlignVertical.center,
              controller: inputController,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: icon,
                prefixIconColor: Colors.white,
                fillColor: const Color.fromARGB(61, 255, 255, 255),
                contentPadding: const EdgeInsets.all(15),
                labelText: title,
                labelStyle:
                    const TextStyle(color: Colors.white70, fontSize: 13),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      )),
    );
  }
}

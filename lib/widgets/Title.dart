import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final Widget content;
  const TitleWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
          height: 110,
          width: double.infinity,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(235, 243, 240, 240),
                  blurStyle: BlurStyle.outer,
                  blurRadius: BorderSide.strokeAlignCenter,
                  offset: Offset(2, 2),
                )
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              color: Color.fromARGB(255, 166, 172, 219)),
          child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: content,
          )
          ),
    );
  }
}

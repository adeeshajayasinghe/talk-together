import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:textapp/constants/constants.dart';

void showStatusDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: const Color.fromARGB(36, 0, 0, 0),
                  ),
                ),
              ),
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: ktextAreaColor,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 48, 179, 199)),
                    ),
                    const Icon(
                      Icons.check_circle_outline_sharp,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

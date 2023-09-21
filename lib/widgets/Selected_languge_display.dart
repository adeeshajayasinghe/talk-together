import 'package:flutter/material.dart';

class SelectedLanguageDiplayWidget extends StatelessWidget {
  final String title;
  final String ChangingVariable;
  const SelectedLanguageDiplayWidget(
      {super.key, required this.ChangingVariable, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 70,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color.fromARGB(255, 0, 238, 255))),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 182, 237, 253), fontSize: 18),
          )),
        ),
        Container(
          height: 70,
          width: 180,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 182, 237, 253)),
          child: Center(
              child: Text(
            ChangingVariable,
            style: const TextStyle(
                color: Color.fromARGB(232, 0, 0, 0), fontSize: 18),
          )),
        )
      ],
    );
  }
}

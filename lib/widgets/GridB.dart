import 'package:flutter/material.dart';
import 'package:textapp/models/Countries.dart';

class GridB extends StatefulWidget {
  final Function(String) setLang;
  const GridB({super.key, required this.setLang});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("clicked");
      },
      child: GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), //this will make the gridview scrolable
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 100),
        itemCount: 9,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              String selectedLanguage = languageList[index];
              widget.setLang(selectedLanguage);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 0, 238, 255)),
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                languageList[index],
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 238, 255), fontSize: 18),
              )),
            ),
          );
        },
      ),
    );
  }
}

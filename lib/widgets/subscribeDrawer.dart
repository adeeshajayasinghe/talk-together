import 'package:flutter/material.dart';

import '../servises/AuthManager.dart';

class drawers extends StatefulWidget {
  const drawers({super.key});

  @override
  State<drawers> createState() => _nameState();
}

class _nameState extends State<drawers> {
  void setText() {
    setState(() {
      AuthManager.subscribe = !AuthManager.subscribe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.all(12),
        children: [
          const SizedBox(
            height: 30,
          ),
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 27, 49),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                Text(
                  'Talk-Together',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'this is the place you talk to the world!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            textColor: AuthManager.subscribe ? Colors.red : Colors.green,
            title: Text(
              AuthManager.subscribe ? "Unsubscribe" : "subscribe",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setText();
            },
          ),
        ],
      ),
    );
  }
}

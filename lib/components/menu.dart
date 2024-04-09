import 'package:flutter/material.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.perm_identity, color: Colors.white, size: 40,)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.white, size: 40,)),
        ],
      ),
    );




  }
}
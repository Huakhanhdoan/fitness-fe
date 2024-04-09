import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: AppColors.colorTheme,
      backgroundColor: Colors.transparent,
      items: const [
        CurvedNavigationBarItem(
          child: Icon(Icons.home, color: Colors.white, size: 40,),),
        CurvedNavigationBarItem(
          child: Icon(Icons.calendar_month, color: Colors.white, size: 40,),),
        CurvedNavigationBarItem(
          child: Icon(Icons.perm_identity, color: Colors.white, size: 40,),),
        CurvedNavigationBarItem(
          child: Icon(Icons.settings, color: Colors.white, size: 40,),),
      ],
      onTap: (index) {
        print(index);
      },
    );




  }
}
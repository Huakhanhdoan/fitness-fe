import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';

class Guide extends StatefulBuilder {
  const Guide({super.key, required super.builder});

  @override
  _GuideState createState() =>_GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        const SizedBox(height: 70,),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Hướng dẫn",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ]),
    );
  }
}

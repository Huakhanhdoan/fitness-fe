import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage7 extends StatefulWidget {
  const IntroPage7({Key? key}) : super(key: key);

  @override
  _IntroPage7 createState() => _IntroPage7();
}

class _IntroPage7 extends State<IntroPage7> {
  String level = 'Male';
  int index = 0;
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/images/remind.svg',
                  width: 150,
                  height: 150,
                  color: Colors.blue.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'THIẾT LẬP NHẮC NHỞ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CupertinoPageScaffold(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 220,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.white,
                            initialDateTime: dateTime,
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (dateTime) {
                              setState(() {
                                this.dateTime = dateTime;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
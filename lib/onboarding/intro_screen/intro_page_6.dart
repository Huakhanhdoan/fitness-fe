import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage6 extends StatefulWidget {
  const IntroPage6({Key? key}) : super(key: key);

  @override
  _IntroPage6 createState() => _IntroPage6();
}

class _IntroPage6 extends State<IntroPage6> {
  String level = 'Male';
  int _currentIntValue = 1500;


  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/images/goal.svg',
                  width: 150,
                  height: 150,
                  color: Colors.red.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'MỤC TIÊU CỦA BẠN LÀ?',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.forward,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    NumberPicker(
                      itemCount: 5,
                      value: _currentIntValue,
                      minValue: 500,
                      maxValue: 20000,
                      step: 500,
                      haptics: true,
                      onChanged: (value) async {
                        //  saveValues();
                        setState(() {
                          _currentIntValue = value;
                        });
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setInt('userTarget', value);
                      },

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black26),
                      ),
                      selectedTextStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 26),
                      textStyle:
                          const TextStyle(color: Colors.green, fontSize: 20),
                    ),
                    const Text(
                      " Bước",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 23),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

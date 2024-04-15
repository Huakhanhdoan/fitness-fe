import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  _IntroPage3 createState() => _IntroPage3();
}

class _IntroPage3 extends State<IntroPage3> {
  String level = 'Male';
int _currentIntValue = 170;
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
                  'assets/images/height.svg',
                  width: 150,
                  height: 150,
                  color: Colors.blue.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'BẠN CAO BAO NHIÊU?',
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
                      child: Icon(Icons.swipe_right_alt, color: Colors.red,size: 40,),
                    ),
                    NumberPicker(
                      itemCount: 5,
                      value: _currentIntValue,
                      minValue: 0,
                      maxValue: 250,
                      step: 1,
                      haptics: true,
                      onChanged: (value) => setState(() => _currentIntValue = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
                        ),
                      selectedTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 26),
                      textStyle: const TextStyle( color: Colors.green, fontSize: 20),
                    ),
                    const Text(" Cm", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 23),)
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

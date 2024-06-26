import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage4 extends StatefulWidget {
  const IntroPage4({super.key});

  @override
  _IntroPage4 createState() => _IntroPage4();
}

class _IntroPage4 extends State<IntroPage4> {
  String level = 'Male';
  int index = 0;
  DateTime dateTime = DateTime.now();

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
                  'assets/images/birthday.svg',
                  width: 150,
                  height: 150,
                  color: Colors.red.shade800,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'NGÀY SINH CỦA BẠN?',
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
                DaysPicker(
                  minDate: DateTime(2021, 1, 1),
                  maxDate: DateTime(2023, 12, 31),
                  onDateSelected: (value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('userDate', value.toString());
                  // Handle selected date
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

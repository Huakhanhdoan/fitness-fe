import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  _IntroPage2 createState() => _IntroPage2();
}

class _IntroPage2 extends State<IntroPage2> {
  String level = 'Male';
   int userWeight =50;


  int index = 0;

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
                  'assets/images/weight.svg',
                  width: 150,
                  height: 150,
                  color: Colors.blue.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'BẠN NẶNG BAO NHIÊU?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [



          Slider(
            value: userWeight.toDouble(),
            min: 0,
            max: 200,
            divisions: 200, // Số bước giữa min và max
            onChanged: (value) {
            //  saveValues();
              setState(() {
                userWeight = value.round();
              });
            },
          ),
          Center(
            child: Text(
              'Cân nặng của bạn: $userWeight''kg',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),


        ],
      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

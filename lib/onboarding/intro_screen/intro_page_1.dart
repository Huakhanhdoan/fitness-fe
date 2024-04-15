

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  _IntroPage1 createState() => _IntroPage1();
}

class _IntroPage1 extends State<IntroPage1> {
  String level = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 60),
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/images/gender.svg',
                  width: 150,
                  height: 150,
                  color: Colors.blue.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'GIỚI TÍNH CỦA BẠN LÀ GÌ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: RadioListTile(
                    value: 'Male',
                    title: Container(
                      child: Text(
                        'Nam',
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    groupValue: level,
                    onChanged: (value) {
                      setState(() {
                        level = value.toString();
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    activeColor: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: RadioListTile(
                    value: 'Female',
                    title: Container(
                      child: Text(
                        'Nữ',
                        style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    groupValue: level,
                    onChanged: (value) {
                      setState(() {
                        level = value.toString();
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    activeColor: Colors.blue.shade800,
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

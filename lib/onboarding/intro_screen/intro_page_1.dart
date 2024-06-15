
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage1 extends StatefulWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  _IntroPage1 createState() => _IntroPage1();
}

class _IntroPage1 extends State<IntroPage1> {
  String level = 'Male';
  String userGender = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 60),
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
                  color: Colors.red.shade800,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'GIỚI TÍNH CỦA BẠN LÀ GÌ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    getOptions("Nam", Icons.man),
                    getOptions("Nữ", Icons.girl),
                    getOptions("Khác", Icons.face),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget getOptions(String name, IconData icon) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            userGender = userGender == name ? "" : name;

          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userGender', userGender);
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
              color: userGender == name ? Colors.red : Colors.grey, // Màu viền
              width: 2.0, // Độ dày viền
            ),
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white70,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20,),
               Container(
                   decoration: BoxDecoration(
                     border: Border.all(
                       color: Colors.green, // Màu viền
                       width: 2.0, // Độ dày viền
                     ),
                     borderRadius: BorderRadius.circular(50),
                   ),
                   child: Icon(icon, color: Colors.green,size: 45,)),
              const SizedBox(width: 20,),
               Text(name, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.check_circle, color: userGender == name ? Colors.red : Colors.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}

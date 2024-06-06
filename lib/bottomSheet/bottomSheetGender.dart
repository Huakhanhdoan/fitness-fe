import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/menu.dart';
class BottomSheetGender extends StatefulWidget {
  const BottomSheetGender({super.key});

  @override
  State<BottomSheetGender> createState() => _BottomSheetGenderState();
}

class _BottomSheetGenderState extends State<BottomSheetGender> {

  String userGender = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'GIỚI TÍNH CỦA BẠN LÀ GÌ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Column(
                    children: [
                      getOptions("Nam", Icons.male),

                  getOptions("Nữ", Icons.female)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap:() {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const Menu(index: 4)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: Colors.green.shade300,
                    ),
                    child: const Center(
                      child: Text(
                        "Xong",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            userGender = userGender == name ? "" : name;

          });
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

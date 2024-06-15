import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/menu.dart';

class BottomSheetStep extends StatefulWidget {
  const BottomSheetStep({super.key});

  @override
  State<BottomSheetStep> createState() => _BottomSheetStepState();
}

class _BottomSheetStepState extends State<BottomSheetStep> {
  int currentIntValue = 1500;
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentIntValue =   prefs.getInt('userTarget') ?? 1500;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MỤC TIÊU CỦA BẠN?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
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
                        itemCount: 3,
                        value: currentIntValue,
                        minValue: 500,
                        maxValue: 20000,
                        step: 500,
                        haptics: true,
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
                        onChanged: (int value) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          setState(() {
                             prefs.setInt('userTarget', value) ;
                          });
                          setState(() {
                            currentIntValue = value;
                          });
                        },
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.green.shade300,
                  ),
                  child: const Center(
                    child: Text(
                      "Xong",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const Menu(index: 4)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

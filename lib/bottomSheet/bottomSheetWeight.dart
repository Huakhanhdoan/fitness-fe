import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/menu.dart';
class BottomSheetWeight extends StatefulWidget {
  const BottomSheetWeight({super.key});

  @override
  State<BottomSheetWeight> createState() => _BottomSheetWeightState();
}

class _BottomSheetWeightState extends State<BottomSheetWeight> {

  int userWeight = 50;
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    userWeight =  prefs.getInt('userWeight') ?? 50;
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
                        'BẠN NẶNG BAO NHIÊU?',
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
                  child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Slider(
                            value: userWeight.toDouble(),
                            min: 0,
                            max: 200,
                            label: '$userWeight',
                            divisions: 200, // Số bước giữa min và max
                            onChanged: (value) async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              setState(() {
                                prefs.setInt('userWeight', value.round());
                              });
                              setState(() {
                                userWeight = value.round();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Cân nặng của bạn: $userWeight' 'kg',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ],
                      )),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => const Menu(index: 2)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


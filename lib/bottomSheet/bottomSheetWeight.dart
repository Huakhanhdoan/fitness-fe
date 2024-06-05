import 'package:flutter/material.dart';

class BottomSheetWeight extends StatelessWidget {
  const BottomSheetWeight({super.key});

  @override
  Widget build(BuildContext context) {
    int userWeight = 50;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 40),
        children: [
          Center(
            child: Column(
              children: [
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
                      divisions: 200,
                      onChanged: (value) {
                        setState(() {
                          userWeight = value.round();
                        });
                      },
                    ),
                    SizedBox(
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void setState(Null Function() param0) {}

import 'package:flutter/material.dart';

class BottomSheetWeight extends StatelessWidget {
  const BottomSheetWeight({super.key});

  @override
  Widget build(BuildContext context) {
    int userWeight = 50;
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Container(
                    child: Column(
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
                ),
                Container(
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
                            onChanged: (value) {
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
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.green.shade300,
                  ),
                  child: Center(
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void setState(Null Function() param0) {
}
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class BottomSheetRemind extends StatelessWidget {
  const BottomSheetRemind({super.key});

  @override
  Widget build(BuildContext context) {
    int userHeight = 170;
    DateTime dateTime = DateTime.now();
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'THIẾT LẬP NHẮC NHỞ?',
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: TimePickerSpinner(
                    locale: const Locale('en', ''),
                    time: dateTime,
                    is24HourMode: false,
                    itemHeight: 80,
                    normalTextStyle: const TextStyle(
                      fontSize: 24,
                    ),
                    highlightedTextStyle:
                        const TextStyle(fontSize: 24, color: Colors.green),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      setState(() {
                        dateTime = time;
                      });
                    },
                  ),
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void setState(Null Function() param0) {}

import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../components/menu.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  double _percent = 0.0;
  bool isBPMEnabled = false;
  Widget? dialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.colorTheme,
        title: const Text('Đo nhịp tim'),
      ),
      body: Column(
        children: [
          isBPMEnabled
              ? HeartBPMDialog(
            context: context,
            borderRadius: 10,
            onRawData: (value) {
              setState(() {
                if (data.length >= 100) data.removeAt(0);
                data.add(value);
              });
            },
            onBPM: (value) => setState(() {
              if (bpmValues.length >= 100) bpmValues.removeAt(0);
              bpmValues.add(SensorValue(
                  value: value.toDouble(), time: DateTime.now()));
            }),
          )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 20.0,
              percent: _percent,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: AppColors.colorTheme,
              animationDuration: 15000, // 15 seconds animation
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/heart.png", width: 50),
                  (bpmValues.isNotEmpty)
                      ? Text(
                    "${bpmValues[bpmValues.length - 1].value}",
                    style: const TextStyle(
                        color: Colors.red, fontSize: 32),
                  )
                      : const Text(
                    "0",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ],
              ),
            ),
          ),

          isBPMEnabled && bpmValues.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red, // Màu viền
                                  width: 2.0,
                                ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            constraints: const BoxConstraints.expand(height: 180),
                            child: BPMChart(bpmValues),
                          ),
              )
              : const SizedBox(),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.favorite_rounded),
              label: Text(isBPMEnabled ? "Dừng đo" : "Bắt đầu đo"),
              onPressed:() {
                if (isBPMEnabled) {
                  setState(() {
                    isBPMEnabled = false;
                    _percent = 0.0; // Reset progress bar on stop
                  });

                } else {
                  setState(() {
                    isBPMEnabled = true;
                    _percent = 1.0;
                  });

                  Future.delayed(const Duration(seconds: 15), () {
                    setState(() {
                      isBPMEnabled = false; // Stop measurement after 10s
                      _percent = 0;
                      // Fill progress bar after 10s
                    });

                  });
                }
              }
            ),
          ),
          Visibility(
            visible: (bpmValues.isNotEmpty && !isBPMEnabled),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Menu(index: 4,)),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text('Lưu dữ liệu'),

              ))
        ],
      ),
    );
  }
}

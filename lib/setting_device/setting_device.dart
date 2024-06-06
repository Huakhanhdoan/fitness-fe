import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

class SettingDevice extends StatefulWidget {
  const SettingDevice({super.key});

  @override
  State<SettingDevice> createState() => _SettingDeviceState();
}

class _SettingDeviceState extends State<SettingDevice> {
  List<StepperData> stepperData1 = [
    StepperData(
      title: StepperText("Cài đặt"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Apps & Notifications"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Running Walking Jogging Goals"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Disable Background restrictions / Background limits"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  ];
  List<StepperData> stepperData2 = [
    StepperData(
      title: StepperText("Cài đặt"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Battery & power saving"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Running Walking Jogging Goals"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    StepperData(
      title: StepperText("Enable Ignore optimizations"),
      iconWidget: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "THIẾT LẬP THIẾT BỊ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Color.fromRGBO(48, 237, 102, 1),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chọn hệ điều hành"),
                    DropdownButton<String?>(
                      items: ["Android", "iOS"]
                          .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                                child: Text(e.toString()),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (String? value) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Center(
              child: Text(
                "Makers of mobile devices frequently pre-install battery savers which greatly slow down your smartphone. It's important to disable or uninstall them from your app list. Check it your device has Doze Mode and make sure it doesn't affect Running Walking Jogging Goals.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "Remove restrictions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: AnotherStepper(
              stepperList: stepperData1,
              stepperDirection: Axis.vertical,
              inActiveBarColor: Colors.greenAccent,
              iconHeight: 10,
              iconWidth: 10,
              verticalGap: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "Alternatively try this:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: AnotherStepper(
              stepperList: stepperData2,
              stepperDirection: Axis.vertical,
              inActiveBarColor: Colors.greenAccent,
              iconHeight: 10,
              iconWidth: 10,
              verticalGap: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

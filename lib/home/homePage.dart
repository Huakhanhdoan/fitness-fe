import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../components/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color colorTheme = AppColors.colorTheme;
  final int _stepGoal = 4000;
  final int _stepCount = 2500;
  double calories = 120.3;
  double distance = 1.21;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HOME",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: colorTheme,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40), // Điều chỉnh độ cong ở đây
          ),
        ),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 23.0,
            animation: true,
            percent: _stepCount / _stepGoal,
            startAngle: 180,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/footprint.png",
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$_stepCount",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
                const Text(
                  'Các bước',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                  elevation: MaterialStateProperty.all<double>(5),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(colorTheme),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Mục tiêu " "$_stepGoal",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: colorTheme,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 4,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 45,
                        color: Colors.orangeAccent,
                      ),
                      Text(
                        '$calories',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Calo')
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 4,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 45,
                        color: Colors.red,
                      ),
                      Text(
                        '$distance' ' km',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Khoảng cách')
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3 - 4,
                  child: const Column(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 45,
                        color: Colors.blue,
                      ),
                      Text(
                        '01h 20p',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Thời gian')
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getOptions(Icons.snowshoeing, "Tổng số bước", "Các bước",
                  _stepCount.toDouble()),
              getOptions(Icons.local_fire_department_rounded, "Tổng lượng Calo",
                  "Kcal", calories),
              getOptions(
                  Icons.social_distance, "Tổng khoảng cách", "km", distance),
              getOptions(Icons.timer, "Tổng thời gian", "phút", 360),
            ],
          )
        ]),
      ),
      bottomNavigationBar: const Menu(),
    );
  }

  Widget getOptions(
      IconData _icon, String _nameCard, String _unit, double value) {
    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Màu của bóng
                spreadRadius: 5, // Độ lan rộng của bóng
                blurRadius: 7, // Độ mờ của bóng
                offset: const Offset(-3, 3), // Độ lệch của bóng
              ),
            ],
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.blue.withOpacity(0.5),
              ],
              stops: const [0.0, 0.7], // Tỷ lệ màu sắc
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                _icon,
                size: 55,
                color: Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_nameCard),
                  Text(
                    '$value',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(_unit),
                ],
              ),

               const Icon(
                  Icons.navigate_next_outlined,
                  size: 45,
                  color: Colors.black,
                ),

            ],
          ),
        ),
      ),
    );
  }
}

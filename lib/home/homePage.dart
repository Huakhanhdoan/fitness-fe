import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';
  late DateTime _lastUpdate;
  final int _stepGoal = 6000;
  int _stepCount = 0;

  double calories = 0;
  double distance = 0;

  @override
  void initState() {
    super.initState();
    loadLastUpdate();
    requestPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        const SizedBox(
          height: 70,
        ),
        CircularPercentIndicator(
          radius: 120.0,
          lineWidth: 23.0,
          animation: true,
          percent: (_stepCount<_stepGoal) ? _stepCount / _stepGoal:1 ,
          startAngle: 180,
          center: CircularPercentIndicator(
            radius: 90,
            lineWidth: 2,
            percent: 1,
            progressColor: Colors.orange,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _status == 'walking'
                      ? Icons.directions_walk
                      : Icons.accessibility_new,
                  size: 70,
                  color: AppColors.colorTheme,
                ),

                Text(
                  _status == 'walking' ? "Walking" : "Stopped",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),

                // Image.asset(
                //   "assets/images/footprint.png",
                //   width: 50,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "$_stepCount",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22.0),
                  ),
                ),
                const Text(
                  'Bước',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
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
                backgroundColor:
                    MaterialStateProperty.all(AppColors.colorTheme),
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
          progressColor: AppColors.colorTheme,
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
                child:  Column(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 45,
                      color: Colors.blue,
                    ),
                    Text(
                      "${_stepCount~/60}"'p',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('Thời gian')
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
            const SizedBox(height: 100,)
          ],
        )
      ]),
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
                Colors.blue.withOpacity(0.8),
                Colors.blue.withOpacity(0.2),
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
  void loadLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastUpdate = DateTime.parse(
        prefs.getString('lastUpdate') ?? DateTime.now().toString()
    );
  }

  void onData(StepCount event) {
    setState(() {
      DateTime now = DateTime.now();
      if (_lastUpdate.day != now.day) {
        _steps = '0';
        _stepCount = 0;
        calories = 0;
        distance = 0;
      }
      _steps = event.steps.toString();
      _stepCount = event.steps;
      _lastUpdate = now;
      saveLastUpdate(_lastUpdate);

      // Calculate calories burned
      double weight = 70; // Your weight in kg
      double stepLength = 0.8; // The length of each step in meters
      double speed = 100 * stepLength / 60; // Speed in m/s, assuming 100 steps per minute
      double height = 1.7; // Your height in meters
      double mins = (_stepCount / 100); // Total minutes walked, assuming 100 steps per minute
      calories = mins * ((0.035 * weight) + ((speed * speed) / height) * 0.029 * weight);
      calories = double.parse(calories.toStringAsFixed(2));
      distance = _stepCount*0.0008;
      distance = double.parse(distance.toStringAsFixed(2));
    });
  }

  void saveLastUpdate(DateTime lastUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastUpdate', lastUpdate.toString());
  }

  void requestPermission() async {
    if (await Permission.activityRecognition.request().isGranted) {
      initPlatformState();
    }
  }



  void onStepCount(StepCount event) {

    setState(() {
      _steps = event.steps.toString();
      _stepCount = int.parse(_steps);
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {

    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {

    setState(() {
      _status = 'Pedestrian Status not available';
    });

  }

  void onStepCountError(error) {

    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _stepCountStream.listen(onData).onError(onStepCountError);

    if (!mounted) return;
  }

}

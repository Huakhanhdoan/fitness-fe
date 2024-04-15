import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitness/home/homePage.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_1.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_2.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_3.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_4.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_5.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_6.dart';
import 'package:fitness/onboarding/intro_screen/intro_page_7.dart';
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  var Pages = [
    IntroPage1(),
    IntroPage2(),
    IntroPage3(),
    IntroPage4(),
    IntroPage5(),
    IntroPage6(),
    IntroPage7(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await _storeOnBoardInfo();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage(title: '',)));
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: Pages
          ),
          Container(
            alignment: Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await _storeOnBoardInfo();
                    _controller.previousPage(
                      duration: const Duration(microseconds: 15000),
                      curve: Curves.bounceIn,
                    );
                    if(currentIndex > 0){
                      currentIndex -= 1;
                      print(currentIndex);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 136, 189, 250),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 7),
                InkWell(
                  onTap: () async {
                    // await _storeOnBoardInfo();
                    _controller.nextPage(
                      duration: Duration(microseconds: 15000),
                      curve: Curves.bounceIn,
                    );
                    currentIndex += 1;
                    print(currentIndex);
                    if(currentIndex == 7){
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => HomePage(title: 'Fitness',)));
                    }
                    // if(Pages.last == const IntroPage7()){
                      // Navigator.pushReplacement(
                      //   context, MaterialPageRoute(builder: (context) => HomePage(title: 'Fitness',)));
                    // }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

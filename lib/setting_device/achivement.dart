import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Achivement extends StatelessWidget {
  const Achivement({super.key});

  Widget _buildMedal(String imagePath, double imageSize, String text) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/images/$imagePath',
                width: imageSize,
                height: imageSize,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }


  Widget _buildSection(String title, List<Widget> medals, Color iconColor, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 30,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: iconColor,
              size: 40,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: medals,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THÀNH TÍCH',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(48, 237, 102, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                'Các bước hàng ngày',
                [
                  _buildMedal( 'grandmaster.png', 60, '1000'),
                  _buildMedal( 'grandmaster.png', 65, '2000'),
                  _buildMedal('grandmaster.png', 70, '3000'),
                  _buildMedal('grandmaster.png', 75, '4000'),
                ],
                Colors.red,
                Icons.directions_walk,
              ),
              _buildSection(
                'Tổng số ngày',
                [
                  _buildMedal('challenger.png', 60, '5 days'),
                  _buildMedal('challenger.png', 65, '10 days'),
                  _buildMedal('challenger.png', 70, '15 days'),
                  _buildMedal('challenger.png', 75, '20 days'),
                ],
                Colors.blue,
                Icons.calendar_today,
              ),
              _buildSection(
                'Tổng khoảng cách',
                [
                  _buildMedal('master.png', 60, '5 km'),
                  _buildMedal('master.png', 65, '10 km'),
                  _buildMedal('master.png', 70, '15 km'),
                  _buildMedal('master.png', 75, '20 km'),
                ],
                Colors.purple,
                Icons.map,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

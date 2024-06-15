import 'package:fitness/history/widget/chart.dart';
import 'package:fitness/untils/color.dart';
import 'package:flutter/material.dart';

class Statistical extends StatelessWidget {
  const Statistical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'THỐNG KÊ',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.colorTheme,
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
      body: Container(
        color: AppColors.backgroundColor,
        child:  Center(
          child:  ListView(

            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Biểu đồ thống kê số bước chạy",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              ),
              LineChartSample2(),
              getOptions("10/6 to 15/6", "2102"),
              getOptions("5/6 to 10/6", "3211"),
              getOptions("1/6 to 5/6", "1162"),

            ],
          ),

        ),
      ),
    );
  }
  Widget getOptions(String date, String step) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.withOpacity(0.8),
                Colors.pink.withOpacity(0.2),
              ],
              stops: const [0.0, 0.7],
            ),

          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey)

        ),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(date),
                Text("$step"" Bước", style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
              ],
            ),
            const SizedBox(
              width: 100,
              // decoration: BoxDecoration(
              //  // color: Colors.greenAccent,
              //
              //     borderRadius: BorderRadius.circular(20.0),
              //     border: Border.all(color: Colors.grey)
              //
              // ),

              child: Center(
                child: Icon(Icons.calendar_month),
              ),
            )
          ],
        ),
      ),
    );
  }
}

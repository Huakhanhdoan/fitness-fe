import 'package:fitness/untils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String date = DateTime.now().toString().substring(0,10);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                border: Border.all(
                  color: Colors.grey, // Màu sắc của viền
                  width: 1, // Độ dày của viền
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Màu của bóng
                    spreadRadius: 1, // Độ lan rộng của bóng
                    blurRadius: 7, // Độ mờ của bóng
                    offset: const Offset(-3, 3), // Độ lệch của bóng
                  ),
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(

                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.colorTheme,

                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20.0), // Adjust corner radius here
                      ),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('2024-04-01 đến ' '$date', style: const TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('3130',style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                              Text('Bước',style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                getContainer("01-04-2024"),
                  getContainer("02-04-2024"),
                  getContainer("03-04-2024"),
                  getContainer("04-04-2024"),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
          const SizedBox(height: 100,)
        ],
      ),
    );
  }
  Widget getContainer(String date) {
    return SizedBox(
      height: 100,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(width: 120, height: 1,color: Colors.grey,),
              Text(date, style:TextStyle(fontWeight: FontWeight.bold, color: AppColors.colorTheme),),
              Container(width: 120, height: 1,color: Colors.grey,)
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.do_not_step, color: Colors.red,),
                    Text("1230 Bước", style: TextStyle(color:  AppColors.colorTheme),),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.social_distance, color: Colors.red,),
                    Text("1.12km", style: TextStyle(color:  AppColors.colorTheme),),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.local_fire_department_rounded, color: Colors.orange,),
                    Text('100 Kcal',style: TextStyle(color:  AppColors.colorTheme)),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.timer, color: Colors.blueAccent,),
                    Text('1h15p',style: TextStyle(color:  AppColors.colorTheme)),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

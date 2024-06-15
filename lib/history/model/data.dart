import 'package:flutter/material.dart';

import '../../untils/color.dart';

class Data extends StatelessWidget{
  final int step;
  final double distance;
  final double calo;
  final int time;
  final String date;

  // Hàm khởi tạo với tham số step
  Data({required this.step, required this.date})
      : distance = calculateDistance(step),
        calo = calculateCalo(step),
        time = calculateTime(step);


  // Các hàm tính toán các thuộc tính khác dựa trên step
  static double calculateDistance(int step) {
    // Lógica tính toán distance dựa trên step
    return double.parse((step * 0.0008).toStringAsFixed(2)); // Ví dụ: Giả sử mỗi bước đi được 0.75 mét
  }

  static double calculateCalo(int step) {
    // Lógica tính toán calo dựa trên step
    return double.parse((step * 0.05).toStringAsFixed(2)); // Ví dụ: Giả sử mỗi bước đi tiêu hao 0.05 calo
  }

  static int calculateTime(int step) {
    // Lógica tính toán time dựa trên step
    return step ~/ 60; // Ví dụ: Giả sử 100 bước đi mất 1 phút
  }

  @override
  Widget build(BuildContext context) {
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
                   Text('$step'" Bước", style: TextStyle(color:  AppColors.colorTheme),),
                 ],
               ),
               Column(
                 children: [
                   const Icon(Icons.social_distance, color: Colors.red,),
                   Text('$distance'"km", style: TextStyle(color:  AppColors.colorTheme),),
                 ],
               ),
               Column(
                 children: [
                   const Icon(Icons.local_fire_department_rounded, color: Colors.orange,),
                   Text('$calo'' Kcal',style: TextStyle(color:  AppColors.colorTheme)),
                 ],
               ),
               Column(
                 children: [
                   const Icon(Icons.timer, color: Colors.blueAccent,),
                   Text('$time''Phút',style: TextStyle(color:  AppColors.colorTheme)),
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

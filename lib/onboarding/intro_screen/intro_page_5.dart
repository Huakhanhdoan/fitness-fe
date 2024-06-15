// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:numberpicker/numberpicker.dart';
//
// class IntroPage5 extends StatefulWidget {
//   const IntroPage5({Key? key}) : super(key: key);
//
//   @override
//   _IntroPage5 createState() => _IntroPage5();
// }
//
// class _IntroPage5 extends State<IntroPage5> {
//   String level = 'Male';
//   String _currentIntValue = 'English';
//   final items = [
//     'English',
//     'Việt Nam',
//   ];
//
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         children: [
//           Center(
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 SvgPicture.asset(
//                   'assets/images/language.svg',
//                   width: 150,
//                   height: 150,
//                   color: Colors.red.shade800,
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 const Text(
//                   'NGÔN NGỮ CỦA BẠN?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Icon(
//                         Icons.forward,
//                         color: Colors.red,
//                         size: 30,
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

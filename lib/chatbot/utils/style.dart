import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size.dart';

Color background = const Color(0xFFFFFFFF);
Color userChat = const Color.fromRGBO(48, 237, 102,1);
Color resChat = const Color(0xFFFB60AB);
Color chatColor = const Color(0xFFFB60AB);
var white = const Color(0xFFFFFFFF);
var black = const Color(0xFF000500);
Color hintColor = const Color(0xFF323232);

TextStyle messageText = GoogleFonts.poppins(color: white, fontSize: small);
TextStyle appBarTitle = GoogleFonts.poppins(color: white, fontWeight: FontWeight.bold);
TextStyle hintText = GoogleFonts.poppins(color: hintColor, fontSize: small);
TextStyle dateText = GoogleFonts.poppins(color: black, fontSize: 13);
TextStyle promptText = GoogleFonts.poppins(color: black, fontSize: small);
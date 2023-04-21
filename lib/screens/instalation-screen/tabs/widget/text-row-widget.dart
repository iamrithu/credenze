import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';

class TextRowWidget extends StatelessWidget {
  final double width;
  final String? lable;
  final String? value;
  const TextRowWidget({Key? key, required this.width, this.lable, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.25,
            child: Text(
              lable!,
              style: GoogleFonts.ptSans(
                  fontSize: width < 700 ? width / 40 : width / 45,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(255, 50, 49, 49),
                  letterSpacing: 0),
            ),
          ),
          Container(
            width: width * 0.02,
            child: Text(
              ":",
              style: GoogleFonts.ptSans(
                  fontSize: width < 700 ? width / 40 : width / 45,
                  fontWeight: FontWeight.w800,
                  color: GlobalColors.themeColor2,
                  letterSpacing: 0),
            ),
          ),
          Container(
            width: width * 0.45,
            child: Text(
              value!,
              style: GoogleFonts.ptSans(
                  fontSize: width < 700 ? width / 40 : width / 45,
                  fontWeight: FontWeight.w600,
                  color:value=="Approved"||value=="Casual"? GlobalColors.green:value=="Pending"?Color.fromRGBO(252,190,1,1):value=="Rejected"||value=="Sick"?Colors.red:value=="Earned"?Color.fromRGBO(176,120,197,1):GlobalColors.black,
                  letterSpacing: 0),
            ),
          ),
        ],
      ),
    );
  }
}

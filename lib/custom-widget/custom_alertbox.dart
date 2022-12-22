import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/global_colors.dart';

class CustomAlertBox extends StatelessWidget {
  final bool success;
  final bool visible;
  final double width;
  final double height;
  final String msg;

  const CustomAlertBox(
      {Key? key,
      required this.success,
      required this.visible,
      required this.width,
      required this.height,
      required this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: success
              ? Color.fromARGB(255, 224, 235, 213)
              : Color.fromARGB(255, 232, 193, 190),
          border: Border(
              left: BorderSide(
                  color: success ? Colors.green : GlobalColors.themeColor,
                  width: 4))),
      width: visible ? width * 0.8 : 0,
      height: visible ? height * 0.06 : height * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                msg,
                style: GoogleFonts.akayaKanadaka(
                    fontSize: width < 700 ? width / 27 : width / 45,
                    fontWeight: FontWeight.w400,
                    color: success ? GlobalColors.black : GlobalColors.white,
                    letterSpacing: 0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.info,
                color: success ? Colors.green : GlobalColors.themeColor),
          )
        ],
      ),
    );
  }
}

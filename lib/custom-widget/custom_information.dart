import 'package:credenze/screens/login-screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/global_colors.dart';

class CustomInformationScreen extends StatefulWidget {
  final String lable;
  final String text;
  const CustomInformationScreen(
      {Key? key, required this.lable, required this.text})
      : super(key: key);

  @override
  _CustomInformationScreenState createState() =>
      _CustomInformationScreenState();
}

class _CustomInformationScreenState extends State<CustomInformationScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.008),
            padding: EdgeInsets.only(left: width * 0.055),
            width: width * 0.35,
            child: Text(
              widget.lable,
              style: GoogleFonts.abel(
                  fontSize: width < 700 ? width / 28 : width / 47,
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.themeColor,
                  letterSpacing: 0),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: width * 0.6,
              child: Text(
                "${widget.text} ",
                style: GoogleFonts.abel(
                    fontSize: width < 700 ? width / 28 : width / 45,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.black,
                    letterSpacing: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

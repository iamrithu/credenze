import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';

class LeadCustomLable extends StatefulWidget {
  final String lable;
  final String? start;
  LeadCustomLable({Key? key, required this.lable, this.start})
      : super(key: key);

  @override
  _LeadCustomLableState createState() => _LeadCustomLableState();
}

class _LeadCustomLableState extends State<LeadCustomLable> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.3,
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: RichText(
        text: TextSpan(
            text: widget.lable,
            style: GoogleFonts.abel(
                fontSize: width < 700 ? width / 28 : width / 45,
                fontWeight: FontWeight.w400,
                color: GlobalColors.black,
                letterSpacing: 0),
            children: [
              TextSpan(
                text: widget.start,
                style: GoogleFonts.abel(
                    fontSize: width < 700 ? width / 28 : width / 45,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.themeColor,
                    letterSpacing: 0),
              ),
            ]),
      ),
    );
  }
}

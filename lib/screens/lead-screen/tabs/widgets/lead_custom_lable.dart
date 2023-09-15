import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';

class LeadCustomlabel extends StatefulWidget {
  final String label;
  final String? start;
  LeadCustomlabel({Key? key, required this.label, this.start})
      : super(key: key);

  @override
  _LeadCustomlabelState createState() => _LeadCustomlabelState();
}

class _LeadCustomlabelState extends State<LeadCustomlabel> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.29,
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: RichText(
        text: TextSpan(
            text: widget.label,
            style: GoogleFonts.ptSans(
                fontSize: width < 700 ? width / 35 : width / 45,
                fontWeight: FontWeight.w400,
                color: GlobalColors.black,
                letterSpacing: 0),
            children: [
              TextSpan(
                text: widget.start,
                style: GoogleFonts.ptSans(
                    fontSize: width < 700 ? width / 35 : width / 45,
                    fontWeight: FontWeight.w400,
                    color: GlobalColors.black,
                    letterSpacing: 0),
              ),
            ]),
      ),
    );
  }
}

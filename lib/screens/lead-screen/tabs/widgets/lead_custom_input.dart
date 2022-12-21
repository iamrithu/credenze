import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';

class LeadCustomInput extends StatefulWidget {
  final String lable;
  final TextEditingController? controller;

  const LeadCustomInput(
      {Key? key, required this.lable, required this.controller})
      : super(key: key);

  @override
  _LeadCustomInputState createState() => _LeadCustomInputState();
}

class _LeadCustomInputState extends State<LeadCustomInput> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.65,
      alignment: AlignmentDirectional.center,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: GlobalColors.themeColor2),
      ),
      child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.lable,
            hintStyle: GoogleFonts.abel(
                color: GlobalColors.themeColor2,
                fontSize: width < 700 ? width / 28 : width / 45,
                fontWeight: FontWeight.w400,
                letterSpacing: 0),
            border: InputBorder.none,
          )),
    );
  }
}

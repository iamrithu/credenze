import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../const/global_colors.dart';

class CustomeAttendenceSchedulaer extends StatefulWidget {
  final int day;
  final DateTime newMonth;
  final String type;
  const CustomeAttendenceSchedulaer(
      {super.key,
      required this.day,
      required this.newMonth,
      required this.type});

  @override
  State<CustomeAttendenceSchedulaer> createState() =>
      _CustomeAttendenceSchedulaerState();
}

class _CustomeAttendenceSchedulaerState
    extends State<CustomeAttendenceSchedulaer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    DateTime _date =
        DateTime(widget.newMonth.year, widget.newMonth.month, widget.day);

    return Column(
      children: [
        Container(
          width: width,
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: width,
                height: height * 0.035,
                child: RichText(
                  text: TextSpan(
                      text: widget.day.toString(),
                      style: GoogleFonts.akayaKanadaka(
                          fontSize: width < 700 ? width / 22 : width / 40,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.themeColor,
                          letterSpacing: 2),
                      children: [
                        TextSpan(
                          text: "  " +
                              DateFormat("EEE").format(DateTime(
                                  widget.newMonth.year,
                                  widget.newMonth.month,
                                  widget.day)),
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 32 : width / 48,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.black,
                              letterSpacing: 2),
                        ),
                      ]),
                ),
              ),
              Card(
                elevation: 1,
                child: Container(
                    alignment: Alignment.center,
                    width: width,
                    height: height * 0.035,
                    child: Center(
                      child: widget.type == "attendence"
                          ? Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 238, 191, 72),
                            )
                          : widget.type == "holiday"
                              ? Icon(
                                  FontAwesomeIcons.tree,
                                  color: Color.fromARGB(255, 5, 91, 28),
                                )
                              : Icon(
                                  Icons.run_circle_outlined,
                                  color: Color.fromARGB(255, 14, 106, 227),
                                ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

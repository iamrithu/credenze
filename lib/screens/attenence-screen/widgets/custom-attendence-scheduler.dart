import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../const/global_colors.dart';

class CustomeAttendenceSchedulaer extends StatefulWidget {
  final int day;
  final DateTime newMonth;
  final String type;
  final Map<String,dynamic>?data;

  const CustomeAttendenceSchedulaer(
      {super.key,
      required this.day,
      required this.newMonth,
      required this.type, required this.data});

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
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.2,
                    height: height * 0.035,
                    child: RichText(
                      text: TextSpan(
                          text: widget.day.toString(),
                          style: GoogleFonts.ptSans(
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
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 32 : width / 48,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.black,
                                  letterSpacing: 2),
                            ),
                          ]),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      child: Container(
                          alignment: Alignment.center,
                          height: height * 0.035,
                          child: Center(
                            child: widget.type == "present"
                                ? Icon(
                                    Icons.check,
                                    color: Color.fromARGB(255, 238, 191, 72),
                                  )
                                : widget.type == "holiday"
                                    ? Icon(
                                        FontAwesomeIcons.tree,
                                        color: Color.fromARGB(255, 5, 91, 28),
                                      )
                                    :widget.type == "leave"? Icon(
                                        Icons.run_circle_outlined,
                                        color:
                                            Color.fromARGB(255, 14, 106, 227),
                                      ):Icon(
                                        Icons.cancel,
                                        color:
                                            GlobalColors.themeColor2,
                                      ),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if( widget.type == "holiday")
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
                        "Holiday",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 30 : width / 48,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor,
                            letterSpacing: 1),
                      ),
          ),
        ),
          if( widget.type == "leave")
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
                        "leave",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 30 : width / 48,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor2,
                            letterSpacing: 1),
                      ),
          ),
        ),
         if( widget.type == "coming")
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
                        "--",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 30 : width / 48,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor,
                            letterSpacing: 1),
                      ),
          ),
        ),
         if( widget.type == "present")
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                       "Clock In Time",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700 ? width / 40: width / 48,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor2,
                                            letterSpacing: 1),
                                      ),
                          ],
                        ),
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Text(
                                        "${widget.data!["clock_in_time"].toString().substring(10)}",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700 ? width / 38 : width / 48,
                                            fontWeight: FontWeight.w600,
                                            color: GlobalColors.black,
                                            letterSpacing: 1),
                                  ),
                                     ],
                                   ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                       "Clock Out Time",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700 ? width / 40: width / 48,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor2,
                                            letterSpacing: 1),
                                      ),
                          ],
                        ),
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Text(
                                        "${widget.data!["clock_out_time"].toString().substring(10)}",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700 ? width / 38 : width / 48,
                                            fontWeight: FontWeight.w600,
                                            color: GlobalColors.black,
                                            letterSpacing: 1),
                                  ),
                                     ],
                                   ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

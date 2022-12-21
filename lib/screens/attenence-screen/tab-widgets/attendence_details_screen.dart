import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../const/global_colors.dart';

class AttendenceDetailsScreen extends StatefulWidget {
  const AttendenceDetailsScreen({Key? key}) : super(key: key);

  @override
  _AttendenceDetailsScreenState createState() =>
      _AttendenceDetailsScreenState();
}

class _AttendenceDetailsScreenState extends State<AttendenceDetailsScreen> {
  DateTime toDay = DateTime.now();
  DateTime newDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              width: width,
              height: width < 500 ? height * 0.05 : height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: DateFormat("MMMM").format(newDate),
                        style: GoogleFonts.abel(
                            fontSize: width < 700 ? width / 16 : width / 22,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor2,
                            letterSpacing: 2),
                        children: [
                          TextSpan(
                            text: " - " + newDate.year.toString(),
                            style: GoogleFonts.abel(
                              fontSize: width < 700 ? width / 22 : width / 45,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.black,
                              letterSpacing: 2,
                            ),
                          ),
                        ]),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final month = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );

                      if (month != null) {
                        setState(() {
                          newDate = month;
                        });
                      }
                    },
                    child: Text(
                      "Pick Date",
                      style: GoogleFonts.abel(
                          fontSize: width < 700 ? width / 28 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: width,
                height: width < 500 ? height * 0.7 : height * 0.85,
                child: LayoutBuilder(builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: width < 500 ? 5 : 4,
                    children: [
                      for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                        if (i < toDay.day)
                          DateFormat("EEEE").format(DateTime(
                                      newDate.year, newDate.month, i)) ==
                                  "Sunday"
                              ? Card(
                                  elevation: 1,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return CustomeAttendenceSchedulaer(
                                      day: i,
                                      newMonth: newDate,
                                      type: "holiday",
                                    );
                                  }),
                                )
                              : Card(
                                  elevation: 1,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return CustomeAttendenceSchedulaer(
                                      day: i,
                                      newMonth: newDate,
                                      type: "attendence",
                                    );
                                  }),
                                ),
                      for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                        if (i == toDay.day)
                          Tooltip(
                            message: "Today",
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 8, 105, 42))),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return CustomeAttendenceSchedulaer(
                                  day: i,
                                  newMonth: newDate,
                                  type: "attendence",
                                );
                              }),
                            ),
                          ),
                      for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                        if (i > toDay.day)
                          DateFormat("EEEE").format(DateTime(
                                      newDate.year, newDate.month, i)) ==
                                  "Sunday"
                              ? Card(
                                  elevation: 1,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return CustomeAttendenceSchedulaer(
                                      day: i,
                                      newMonth: newDate,
                                      type: "holiday",
                                    );
                                  }),
                                )
                              : Card(
                                  elevation: 1,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    return Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: width,
                                          height: height * 0.035,
                                          child: RichText(
                                            text: TextSpan(
                                                text: i.toString(),
                                                style: GoogleFonts.abel(
                                                    fontSize: width < 700
                                                        ? width / 22
                                                        : width / 40,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        GlobalColors.themeColor,
                                                    letterSpacing: 2),
                                                children: [
                                                  TextSpan(
                                                    text: "  " +
                                                        DateFormat("EEE")
                                                            .format(DateTime(
                                                                newDate.year,
                                                                newDate.month,
                                                                i)),
                                                    style: GoogleFonts.abel(
                                                        fontSize: width < 700
                                                            ? width / 32
                                                            : width / 48,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            GlobalColors.black,
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
                                                child: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Color.fromARGB(
                                                        255, 213, 26, 12)),
                                              )),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}

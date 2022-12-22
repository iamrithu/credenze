import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../const/global_colors.dart';

class HolidayDetailsScreen extends StatefulWidget {
  const HolidayDetailsScreen({Key? key}) : super(key: key);

  @override
  _HolidayDetailsScreenState createState() => _HolidayDetailsScreenState();
}

class _HolidayDetailsScreenState extends State<HolidayDetailsScreen> {
  DateTime newDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
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
                      style: GoogleFonts.akayaKanadaka(
                          fontSize: width < 700 ? width / 16 : width / 22,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.themeColor2,
                          letterSpacing: 2),
                      children: [
                        TextSpan(
                          text: " - " + newDate.year.toString(),
                          style: GoogleFonts.akayaKanadaka(
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
                    style: GoogleFonts.akayaKanadaka(
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
              height: width < 500 ? height * 0.633 : height * 0.66,
              child: LayoutBuilder(builder: (context, constraints) {
                return GridView.count(
                  crossAxisCount: width < 500 ? 5 : 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: [
                    for (var i = 1;
                        i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                        i++)
                      if (DateFormat("EEEE").format(
                              DateTime(newDate.year, newDate.month, i)) ==
                          "Sunday")
                        Card(
                          elevation: 1,
                          child: LayoutBuilder(builder: (context, constraints) {
                            return CustomeAttendenceSchedulaer(
                              day: i,
                              newMonth: newDate,
                              type: "holiday",
                            );
                          }),
                        ),
                  ],
                );
              })),
        ],
      ),
    );
  }
}

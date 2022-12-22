import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../apis/notification_api.dart';
import '../../../const/global_colors.dart';
import '../widgets/leave_apply_screen.dart';

class LeaveDetailsScreen extends StatefulWidget {
  const LeaveDetailsScreen({Key? key}) : super(key: key);

  @override
  _LeaveDetailsScreenState createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends State<LeaveDetailsScreen> {
  DateTime newDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return LeaveApplyScreen();
            },
          );
        },
        icon: Icon(
          Icons.add,
          color: GlobalColors.themeColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: GlobalColors.themeColor, width: 2),
              borderRadius: BorderRadius.circular(50)),
        ),
        label: Text(
          "Add Leave",
          style: GoogleFonts.akayaKanadaka(
              color: GlobalColors.themeColor,
              fontSize: width < 700 ? width / 28 : width / 45,
              fontWeight: FontWeight.w400,
              letterSpacing: 0),
        ),
      ),
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
                  crossAxisCount: width < 500 ? 5 : 3,
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
                              type: "leave",
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

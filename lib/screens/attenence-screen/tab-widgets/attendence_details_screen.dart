import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../apis/api.dart';
import '../../../const/global_colors.dart';
import '../../../river-pod/riverpod_provider.dart';

class AttendenceDetailsScreen extends ConsumerStatefulWidget {
  const AttendenceDetailsScreen({Key? key}) : super(key: key);

  @override
  _AttendenceDetailsScreenState createState() =>
      _AttendenceDetailsScreenState();
}

class _AttendenceDetailsScreenState
    extends ConsumerState<AttendenceDetailsScreen> {
  DateTime toDay = DateTime.now();
  DateTime newDate = DateTime.now();
  List<dynamic> holidays = [];
  List<dynamic> present = [];

  getHoliday() {
    Api()
        .getHoliday(ref.read(newToken)!, DateFormat("yyyy").format(newDate),
            DateFormat("MM").format(newDate))
        .then((value) {
      setState(() {
        holidays = value.data["data"];
      });
    });
  }

  getPresent() {
    Api()
        .getPresentDays(ref.read(newToken)!, DateFormat("yyyy").format(newDate),
            DateFormat("MM").format(newDate))
        .then((value) {
      setState(() {
        present = value.data["data"];
      });
    });
  }

  fillterDates(val) {
    for (var i = 0; i < holidays.length; i++) {
      if (val == DateTime.parse(holidays[i]["date"]).day) {
        return Card(
          elevation: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            return CustomeAttendenceSchedulaer(
              day: val,
              newMonth: newDate,
              type: "holiday",
              data:null
            );
          }),
        );
      }
    }

    for (var i = 0; i < present.length; i++) {
    
      if (val == DateTime.parse(present[i]["attendance_date"]).day) {
        return Card(
          elevation: val==toDay.day?10: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color:  val==toDay.day?GlobalColors.green:GlobalColors.white),
            borderRadius: BorderRadius.circular(5)
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return CustomeAttendenceSchedulaer(
              day: val,
              newMonth: newDate,
              type: "present",
              data:present[i] ,
            );
          }),
        );
      }
    }

      return Card(
          elevation: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            return CustomeAttendenceSchedulaer(
              day: val,
              newMonth: newDate,
              type: "leave",
              data: null,
            );
          }),
        );
      
  }
  fillterAfterDates(val) {
    for (var i = 0; i < holidays.length; i++) {
      if (val == DateTime.parse(holidays[i]["date"]).day) {
        return Card(
          elevation: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            return CustomeAttendenceSchedulaer(
              day: val,
              newMonth: newDate,
              type: "holiday",
              data:null
            );
          }),
        );
      }
    }

    
      return Card(
          elevation: 1,
          child: LayoutBuilder(builder: (context, constraints) {
            return CustomeAttendenceSchedulaer(
              day: val,
              newMonth: newDate,
              type: "coming",
              data: null,
            );
          }),
        );
      
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoliday();
    getPresent();
  }

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
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 16 : width / 22,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor2,
                            letterSpacing: 2),
                        children: [
                          TextSpan(
                            text: " - " + newDate.year.toString(),
                            style: GoogleFonts.ptSans(
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
                        getHoliday();
                        getPresent();
                      }
                    },
                    child: Text(
                      "Pick Date",
                      style: GoogleFonts.ptSans(
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
              height: width < 500 ? height * 0.8 : height * 0.85,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: width < 500 ? 3 : 4,
                    children: [
                
  if(DateTime.now().month!=newDate.month)
                      for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                          
                        fillterDates(i),
                     if(DateTime.now().month==newDate.month)
                      for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                           if(i<=toDay.day)
                        fillterDates(i),

                     if(DateTime.now().month==newDate.month)
                          for (var i = 1;
                          i <= DateTime(newDate.year, newDate.month + 1, 0).day;
                          i++)
                          if(i>toDay.day)
                        fillterAfterDates(i),
                    
                                SizedBox(),
                                 SizedBox(),
                                  SizedBox(),
                    ],
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}

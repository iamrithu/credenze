import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/attenence-screen/tab-widgets/attendence_details_screen.dart';
import 'package:credenze/screens/attenence-screen/tab-widgets/holidy_details.dart';
import 'package:credenze/screens/attenence-screen/tab-widgets/permission_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'tab-widgets/leave_details_screen.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({Key? key}) : super(key: key);

  @override
  _AttendenceScreenState createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: width < 700 ? height * 0.8 : height * 0.9,
      child: LayoutBuilder(builder: ((context, constraints) {
        return DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color.fromARGB(15, 255, 255, 255),
              bottom: PreferredSize(
                preferredSize: Size(width, height * 0.04),
                child: Card(
                  child: TabBar(
                    labelColor: GlobalColors.themeColor,
                    unselectedLabelColor: GlobalColors.themeColor2,
                    indicatorSize: TabBarIndicatorSize.label,
                    dragStartBehavior: DragStartBehavior.start,
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return GlobalColors.themeColor2;
                      }
                      return GlobalColors.themeColor;
                    }),
                    splashBorderRadius: BorderRadius.circular(4),
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "Working Days",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 38 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.work_history,
                          size: width < 700 ? width / 38 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Holidays",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 38 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.holiday_village,
                          size: width < 700 ? width / 38 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Leaves",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 38 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.leave_bags_at_home_outlined,
                          size: width < 700 ? width / 38 : width / 45,
                        ),
                      ),
                       Tab(
                        child: Text(
                          "Permissions",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 34 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.leave_bags_at_home_outlined,
                          size: width < 700 ? width / 34 : width / 45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              child: TabBarView(
                children: <Widget>[
                
                  AttendenceDetailsScreen(),
                  HolidayDetailsScreen(),
                  LeaveDetailsScreen(),
                  PermissionDetailsScreen()

                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

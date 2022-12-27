import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/lead-screen/tabs/follow-up-screen-list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'tabs/add-leads-screen.dart';
import 'tabs/lead_list_screen.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({Key? key}) : super(key: key);

  @override
  _LeadScreenState createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: width < 700 ? height * 0.8 : height * 0.86,
      child: LayoutBuilder(builder: ((context, constraints) {
        return DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: GlobalColors.white,
              automaticallyImplyLeading: false,
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
                          "Leads",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.install_desktop_sharp,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Add Leads",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.task_rounded,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Follow Up",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.follow_the_signs,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                LeadListingScreen(),
                LeadAddingScreen(),
                FollowUpListScreen(),
              ],
            ),
          ),
        );
      })),
    );
  }
}

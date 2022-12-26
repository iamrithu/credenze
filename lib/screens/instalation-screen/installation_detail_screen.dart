import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/instalation-screen/tabs/members-screen.dart';

import 'package:credenze/screens/instalation-screen/tabs/overview-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/task-screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class InstallationDetailScreen extends StatefulWidget {
  const InstallationDetailScreen({Key? key}) : super(key: key);

  @override
  _InstallationDetailScreenState createState() =>
      _InstallationDetailScreenState();
}

class _InstallationDetailScreenState extends State<InstallationDetailScreen> {
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
                          "Overview",
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.view_comfy,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Task",
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.task_sharp,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Members",
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.person_add,
                          size: width < 700 ? width / 28 : width / 45,
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Files",
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        icon: Icon(
                          Icons.file_upload_outlined,
                          size: width < 700 ? width / 28 : width / 45,
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
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return OverviewScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return TaskScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return MemberScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Add Files",
                        style: GoogleFonts.akayaKanadaka(
                            fontSize: width < 700 ? width / 28 : width / 45,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

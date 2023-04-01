import 'package:credenze/screens/instalation-screen/tabs/expenses-screen.dart';
import 'package:credenze/screens/task/timeLogScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../const/global_colors.dart';
import 'commentScreen.dart';
import 'expensScreen.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen>
    with SingleTickerProviderStateMixin {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late TabController tabController;
  List<String> tabName = [
    "Overview",
    "Task",
    "Members",
    "Files",
  ];
  List<IconData> tabIcon = [
    Icons.view_comfy,
    Icons.task_sharp,
    Icons.person_add,
    Icons.file_upload_outlined,
  ];
  bool isTimerOn = true;
  bool isCompleted = true;
  int tabPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(8),
      width: width,
      height: height,
      child: Column(
        children: [
          Container(
            width: width,
            height: height * 0.08,
            padding: EdgeInsets.all(4),
            child: Card(
              child: Row(
                children: [
                  Container(
                    width: width * 0.3,
                    height: height * 0.8,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isCompleted = !isCompleted;
                        });
                      },
                      child: Card(
                        color: isCompleted
                            ? GlobalColors.themeColor
                            : GlobalColors.themeColor2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: GlobalColors.themeColor2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                isCompleted ? Icons.check : Icons.close,
                                color: GlobalColors.white,
                                size: width < 700 ? width / 25 : width / 45,
                              ),
                              Spacer(),
                              Text(
                                isCompleted
                                    ? "Mark As Complete"
                                    : "Mark As Incomplete",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.white,
                                    fontSize:
                                        width < 700 ? width / 40 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.25,
                    height: height * 0.8,
                    child: InkWell(
                      onTap: () {
                        if (isTimerOn) {
                          _stopWatchTimer.onStartTimer();
                        } else {
                          _stopWatchTimer.onStopTimer();
                        }
                        return setState(() {
                          isTimerOn = !isTimerOn;
                        });
                      },
                      child: Card(
                        color: isTimerOn
                            ? GlobalColors.themeColor
                            : GlobalColors.themeColor2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: GlobalColors.themeColor2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(
                                  isTimerOn ? Icons.play_arrow : Icons.pause,
                                  color: GlobalColors.white,
                                  size: width < 700 ? width / 25 : width / 45,
                                ),
                                Spacer(),
                                Text(
                                  isTimerOn ? "Start Timer" : "Stop Timer",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.white,
                                      fontSize:
                                          width < 700 ? width / 40 : width / 45,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // if (!isTimerOn)
                  Expanded(
                    child: Card(
                      color: Color.fromARGB(255, 245, 235, 235),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: GlobalColors.themeColor)),
                      child: Center(
                          child: StreamBuilder(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: ((context, snapshot) {
                          final value = snapshot.data;
                          final displayTimeWithoutSec =
                              StopWatchTimer.getDisplayTime(value!,
                                  hours: true,
                                  minute: true,
                                  second: false,
                                  milliSecond: false);
                          final displayTimeWithSec =
                              StopWatchTimer.getDisplayTime(value,
                                  hours: false,
                                  minute: false,
                                  second: true,
                                  milliSecond: false);
                          return Padding(
                            padding: EdgeInsets.all(width * 0.02),
                            child: RichText(
                              text: TextSpan(
                                text: displayTimeWithoutSec.toString() +
                                    ":" +
                                    displayTimeWithSec.toString(),
                                style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 25 : width / 24,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.themeColor,
                                    letterSpacing: 2),
                              ),
                            ),
                          );
                        }),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.25,
            margin: EdgeInsets.all(2),
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Brance",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "Covai",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Category",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "Others",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Start Date",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "31-03-2023",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Due Date ",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "30-03-2023",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Assigend",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "rithi",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Status",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "Incomplete",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Priority",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                        Text(":"),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width * 0.45,
                          child: Text(
                            "Medium",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 232, 232),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                TabBar(
                  onTap: (int) {
                    setState(() {
                      tabPage = int;
                    });
                  },
                  indicatorColor: GlobalColors.white,
                  labelColor: GlobalColors.white,
                  indicator: BoxDecoration(
                      color: GlobalColors.themeColor,
                      borderRadius: BorderRadius.circular(5)),
                  controller: tabController,
                  unselectedLabelColor: GlobalColors.themeColor,
                  tabs: [
                    Tab(text: "Comment"),
                    Tab(text: "Time Logs"),
                    Tab(text: "Expanse"),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          if (tabPage == 0)
            Container(
              width: width,
              height: height * 0.38,
              child: CommentScreen(),
            ),
          if (tabPage == 1)
            Container(
                width: width, height: height * 0.38, child: TimeLogScreen()),
          if (tabPage == 2)
            Container(
              width: width,
              height: height * 0.38,
              child: MainExpenseScreen(),
            ),
        ],
      ),
    );
  }
}

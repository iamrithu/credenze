import 'dart:convert';

import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../const/global_colors.dart';
import 'commentScreen.dart';
import 'expensScreen.dart';

class OverViewScreen extends ConsumerStatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends ConsumerState<OverViewScreen>
    with SingleTickerProviderStateMixin {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late TabController tabController;

  List<dynamic> getUsers = [];
  List<int> getUsersId = [];
  List<dynamic> getUsersName = [];

  bool isTimerOn = true;
  bool isPaused = false;
  bool isCompleted = true;
  bool isLoading = false;
  int activeTimerId = 0;
  int pauseTimerId = 0;

  int tabPage = 0;

  bool reassignMember = false;

  var object = {};

  triggerTimaer(DateTime v1, DateTime v2) {
    Duration diff = v1.difference(v2);

    _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
    _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
    _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
  }

  getActiveTimer() {
    Api()
        .getActiveTimer(ref.read(newToken)!, ref.read(publicTaskId))
        .then((value) {
      if (value.data["success"]) {
        setState(() {
          activeTimerId = value.data["data"]["id"];
        });
        if (value.data["data"]["breaks"].length < 1) {
          _stopWatchTimer.onStopTimer();
          _stopWatchTimer.clearPresetTime();
          _stopWatchTimer.onResetTimer();

          _stopWatchTimer.setPresetHoursTime(int.parse(
              value.data["data"]["timer"][0] + value.data["data"]["timer"][1]));
          _stopWatchTimer.setPresetMinuteTime(int.parse(
              value.data["data"]["timer"][3] + value.data["data"]["timer"][4]));
          _stopWatchTimer.setPresetSecondTime(int.parse(
              value.data["data"]["timer"][6] + value.data["data"]["timer"][7]));
          _stopWatchTimer.onStartTimer();
          setState(() {
            isTimerOn = false;
          });
        } else {
          setState(() {
            pauseTimerId = value.data["data"]["breaks"]
                [value.data["data"]["breaks"].length - 1]["id"];
          });
          if (value.data["data"]["breaks"]
                      [value.data["data"]["breaks"].length - 1]["start_time"] !=
                  null &&
              value.data["data"]["breaks"]
                      [value.data["data"]["breaks"].length - 1]["end_time"] !=
                  null) {
            _stopWatchTimer.clearPresetTime();
            _stopWatchTimer.onResetTimer();

            _stopWatchTimer.setPresetHoursTime(int.parse(value.data["data"]
                    ["timer"][0] +
                value.data["data"]["timer"][1]));
            _stopWatchTimer.setPresetMinuteTime(int.parse(value.data["data"]
                    ["timer"][3] +
                value.data["data"]["timer"][4]));
            _stopWatchTimer.setPresetSecondTime(int.parse(value.data["data"]
                    ["timer"][6] +
                value.data["data"]["timer"][7]));
            _stopWatchTimer.onStartTimer();
            setState(() {
              isTimerOn = false;
            });
          } else {
            _stopWatchTimer.onStopTimer();
            _stopWatchTimer.clearPresetTime();
            _stopWatchTimer.onResetTimer();

            _stopWatchTimer.setPresetHoursTime(int.parse(value.data["data"]
                    ["timer"][0] +
                value.data["data"]["timer"][1]));
            _stopWatchTimer.setPresetMinuteTime(int.parse(value.data["data"]
                    ["timer"][3] +
                value.data["data"]["timer"][4]));
            _stopWatchTimer.setPresetSecondTime(int.parse(value.data["data"]
                    ["timer"][6] +
                value.data["data"]["timer"][7]));
            setState(() {
              isTimerOn = false;
              isPaused = true;
            });
          }
        }
      }
    });
  }

  startTimer() {
    Api().startTimer(ref.read(newToken)!, ref.read(publicTaskId)).then((value) {
      print(value.toString());
      if (value.data["success"]) {
        setState(() {
          isTimerOn = false;
        });

        _stopWatchTimer.onStartTimer();

        getActiveTimer();
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "${value.data["message"]}",
            autoCloseDuration: null);
      }
    });
  }

  stopTimer() {
    Api().stopTimer(ref.read(newToken)!, activeTimerId).then((value) {
      if (value.data["success"]) {
        _stopWatchTimer.onStopTimer();
        setState(() {
          isTimerOn = !isTimerOn;
        });
        getActiveTimer();
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "${value.data["message"]}",
            autoCloseDuration: null);
        getActiveTimer();
      }
    });
  }

  pauseTimer() {
    Api().pauseTimer(ref.read(newToken)!, activeTimerId).then((value) {
      if (value.data["success"]) {
        setState(() {
          isPaused = true;
        });

        _stopWatchTimer.clearPresetTime();
        _stopWatchTimer.onStopTimer();
        getActiveTimer();
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "${value.data["message"]}",
            autoCloseDuration: null);
        getActiveTimer();
      }
    });
  }

  resumeTimer() {
    Api().resumeTimer(ref.read(newToken)!, pauseTimerId).then((value) {
      if (value.data["success"]) {
        _stopWatchTimer.onStartTimer();
        setState(() {
          isPaused = false;
        });
        getActiveTimer();
      } else {
        QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "${value.data["message"]}",
            autoCloseDuration: null);
        getActiveTimer();
      }
    });
  }

  assignMember() {
    Api()
        .publicTaskView(ref.read(newToken)!, ref.read(publicTaskId))
        .then((value) {
      setState(() {
        object = value;
        getUsersName = jsonDecode(value["assigned_names"]);
        isCompleted = object["status"] == "completed" ? false : true;
      });

      for (var i = 0; i < jsonDecode(object["assigned_ids"]).length; i++) {
        setState(() {
          getUsersId.add(jsonDecode(object["assigned_ids"])[i]);
        });
      }
      Api().BranchUsers(ref.read(newToken)!, object["branch_id"]).then((value) {
        setState(() {
          getUsers = value;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Api()
        .publicTaskView(ref.read(newToken)!, ref.read(publicTaskId))
        .then((value) {
      setState(() {
        object = value;
        getUsersName = jsonDecode(value["assigned_names"]);
        isCompleted = object["status"] == "completed" ? false : true;
      });

      for (var i = 0; i < jsonDecode(object["assigned_ids"]).length; i++) {
        setState(() {
          getUsersId.add(jsonDecode(object["assigned_ids"])[i]);
        });
      }
      Api().BranchUsers(ref.read(newToken)!, object["branch_id"]).then((value) {
        setState(() {
          getUsers = value;
        });
      });
    });

    getActiveTimer();

    tabController = TabController(length: 2, vsync: this);
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
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Column(
              children: [
                if (isCompleted)
                  Container(
                    width: width,
                    height: height * 0.08,
                    padding: EdgeInsets.all(4),
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            width: isCompleted ? width * 0.27 : width * 0.35,
                            height: height * 0.8,
                            child: InkWell(
                              onTap: () {
                                if (isPaused == true) {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title:
                                          "The timer is paused so can not complete the task",
                                      autoCloseDuration: null);

                                  return null;
                                }
                                if (isTimerOn == false) {
                                  QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      title:
                                          "The timer is running so can not complete the task",
                                      autoCloseDuration: null);

                                  return null;
                                }
                                setState(() {
                                  isLoading = true;
                                });
                                Api()
                                    .publicTaskStatus(
                                        ref.read(newToken)!,
                                        ref.read(publicTaskId),
                                        object["status"] == "incomplete"
                                            ? "completed"
                                            : "incompleted")
                                    .then((value) {
                                  Api()
                                      .publicTaskView(ref.read(newToken)!,
                                          ref.read(publicTaskId))
                                      .then((value) {
                                    setState(() {
                                      object = value;
                                    });

                                    setState(() {
                                      isLoading = false;
                                      isCompleted =
                                          object["status"] == "completed"
                                              ? false
                                              : true;
                                    });
                                  });
                                });
                              },
                              child: Card(
                                color: isCompleted
                                    ? GlobalColors.themeColor
                                    : GlobalColors.themeColor2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color: GlobalColors.themeColor2)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        isCompleted ? Icons.check : Icons.close,
                                        color: GlobalColors.white,
                                        size: width < 700
                                            ? width / 25
                                            : width / 45,
                                      ),
                                      Text(
                                        isCompleted
                                            ? "Mark As Complete"
                                            : "Mark As Incomplete",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.white,
                                            fontSize: width < 700
                                                ? width / 45
                                                : width / 60,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (isCompleted)
                            if (isTimerOn)
                              Container(
                                width: width * 0.25,
                                height: height * 0.8,
                                child: InkWell(
                                  onTap: () {
                                    startTimer();
                                  },
                                  child: Card(
                                    color: isTimerOn
                                        ? GlobalColors.themeColor
                                        : GlobalColors.themeColor2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color: GlobalColors.themeColor2)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              isTimerOn
                                                  ? Icons.play_arrow
                                                  : Icons.pause,
                                              color: GlobalColors.white,
                                              size: width < 700
                                                  ? width / 25
                                                  : width / 45,
                                            ),
                                            Text(
                                              isTimerOn
                                                  ? "Start Timer"
                                                  : "Stop Timer",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.white,
                                                  fontSize: width < 700
                                                      ? width / 40
                                                      : width / 45,
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
                          if (isPaused)
                            Container(
                              width: width * 0.26,
                              height: height * 0.8,
                              child: InkWell(
                                onTap: () {
                                  resumeTimer();
                                },
                                child: Card(
                                  color: GlobalColors.themeColor2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                          color: GlobalColors.themeColor2)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.play_arrow,
                                            color: GlobalColors.white,
                                            size: width < 700
                                                ? width / 25
                                                : width / 45,
                                          ),
                                          Text(
                                            "Resume Timer",
                                            style: GoogleFonts.ptSans(
                                                color: GlobalColors.white,
                                                fontSize: width < 700
                                                    ? width / 48
                                                    : width / 45,
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
                          if (!isPaused)
                            if (!isTimerOn)
                              Container(
                                width: width * 0.2,
                                height: height * 0.8,
                                child: InkWell(
                                  onTap: () {
                                    pauseTimer();
                                  },
                                  child: Card(
                                    color: GlobalColors.themeColor2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color: GlobalColors.themeColor2)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              isTimerOn
                                                  ? Icons.play_arrow
                                                  : Icons.pause,
                                              color: GlobalColors.white,
                                              size: width < 700
                                                  ? width / 25
                                                  : width / 45,
                                            ),
                                            Text(
                                              "Pause Timer",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.white,
                                                  fontSize: width < 700
                                                      ? width / 47
                                                      : width / 45,
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
                          if (!isPaused)
                            if (!isTimerOn)
                              Container(
                                width: width * 0.18,
                                height: height * 0.8,
                                child: InkWell(
                                  onTap: () {
                                    stopTimer();
                                  },
                                  child: Card(
                                    color: GlobalColors.themeColor2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(
                                            color: GlobalColors.themeColor2)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.stop,
                                              color: GlobalColors.white,
                                              size: width < 700
                                                  ? width / 25
                                                  : width / 45,
                                            ),
                                            Text(
                                              "Stop Timer",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.white,
                                                  fontSize: width < 700
                                                      ? width / 47
                                                      : width / 45,
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
                          if (!isTimerOn)
                            Expanded(
                              child: Card(
                                elevation: 10,
                                color: Color.fromARGB(255, 245, 235, 235),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        color: GlobalColors.themeColor)),
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
                                          text:
                                              displayTimeWithoutSec.toString() +
                                                  ":" +
                                                  displayTimeWithSec.toString(),
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 45
                                                  : width / 24,
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
                Expanded(
                  child: ListView(
                    children: object.isEmpty
                        ? []
                        : [
                            Container(
                              width: width,
                              margin: EdgeInsets.all(2),
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Task Title",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "${object["task_title"] ?? "--"}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Branch",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "${object["branch"]["location"] ?? "--"}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Category",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "${object["category"]["category_name"] ?? "--"}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Start Date",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateTime.parse(object["start_date"]))}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Due Date ",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              "${DateFormat("dd-MM-yyyy").format(DateTime.parse(object["due_date"]))}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Status",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              object["status"]
                                                      .toString()[0]
                                                      .toUpperCase() +
                                                  object["status"]
                                                      .toString()
                                                      .substring(1),
                                              style: GoogleFonts.ptSans(
                                                  color: object["status"]
                                                              .toString() ==
                                                          "completed"
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Priority",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: Text(
                                              object["priority"] == null
                                                  ? "--"
                                                  : object["priority"][0]
                                                          .toString()
                                                          .toUpperCase() +
                                                      object["priority"]
                                                          .toString()
                                                          .substring(1),
                                              style: GoogleFonts.ptSans(
                                                  color: object["priority"] ==
                                                          "high"
                                                      ? GlobalColors.themeColor
                                                      : object["priority"] ==
                                                              "medium"
                                                          ? Color.fromARGB(
                                                              255, 255, 163, 59)
                                                          : Colors.green,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: width * 0.3,
                                            child: Text(
                                              "Description",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Text(":"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: width * 0.45,
                                            child: HtmlWidget(
                                              object["description"]
                                                      .toString()
                                                      .trim() ??
                                                  "--",
                                              textStyle: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 38
                                                      : width / 45,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Assigned Members",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0),
                                  ),
                                ],
                              ),
                            ),
                            if (isCompleted)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            reassignMember = true;
                                          });
                                        },
                                        child: Container(
                                          height: height * 0.05,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color:
                                                      GlobalColors.themeColor)),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  Text(
                                                    getUsersName
                                                        .toString()
                                                        .replaceAll('[', "")
                                                        .replaceAll(']', "")
                                                        .replaceAll('"', ""),
                                                    style: GoogleFonts.ptSans(
                                                        color: GlobalColors
                                                            .themeColor2,
                                                        fontSize: width < 700
                                                            ? width / 35
                                                            : width / 45,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     setState(() {
                                    //       reassignMember = true;
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: GlobalColors.themeColor,
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //     width: width * 0.3,
                                    //     height: height * 0.06,
                                    //     child: Center(
                                    //       child: Text(
                                    //         "Reassign",
                                    //         style: GoogleFonts.ptSans(
                                    //             color: GlobalColors.white,
                                    //             fontSize: width < 700
                                    //                 ? width / 35
                                    //                 : width / 45,
                                    //             fontWeight: FontWeight.w500,
                                    //             letterSpacing: 0),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),

                            if (!isCompleted)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: height * 0.05,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color:
                                                      GlobalColors.themeColor)),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Wrap(
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  Text(
                                                    getUsersName
                                                        .toString()
                                                        .replaceAll('[', "")
                                                        .replaceAll(']', "")
                                                        .replaceAll('"', ""),
                                                    style: GoogleFonts.ptSans(
                                                        color: GlobalColors
                                                            .themeColor2,
                                                        fontSize: width < 700
                                                            ? width / 35
                                                            : width / 45,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: 0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     setState(() {
                                    //       reassignMember = true;
                                    //     });
                                    //   },
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: GlobalColors.themeColor,
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //     width: width * 0.3,
                                    //     height: height * 0.06,
                                    //     child: Center(
                                    //       child: Text(
                                    //         "Reassign",
                                    //         style: GoogleFonts.ptSans(
                                    //             color: GlobalColors.white,
                                    //             fontSize: width < 700
                                    //                 ? width / 35
                                    //                 : width / 45,
                                    //             fontWeight: FontWeight.w500,
                                    //             letterSpacing: 0),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),

                            // if (tabPage == 1)
                            //   Container(
                            //       width: width,
                            //       height: height * 0.38,
                            //       child: TimeLogScreen()),
                          ],
                  ),
                ),
              ],
            ),
          ),
          if (reassignMember)
            Container(
              width: width,
              height: height,
              color: Color.fromARGB(205, 255, 255, 255),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      width: width,
                      color: GlobalColors.white,
                      height: height,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              width: width,
                              height: height * 0.6,
                              child: ListView(
                                children: [
                                  if (getUsers.isNotEmpty)
                                    for (var i = 0; i < getUsers.length; i++)
                                      InkWell(
                                        onTap: () {
                                          if (getUsersName.isEmpty) {
                                            setState(() {
                                              getUsersName
                                                  .add(getUsers[i]["name"]);
                                              getUsersId.add(getUsers[i]["id"]);
                                            });
                                          } else {
                                            if (getUsersName.contains(
                                                getUsers[i]["name"])) {
                                              setState(() {
                                                getUsersName.remove(
                                                    getUsers[i]["name"]);
                                                getUsersId
                                                    .remove(getUsers[i]["id"]);
                                              });
                                            } else {
                                              setState(() {
                                                getUsersName
                                                    .add(getUsers[i]["name"]);
                                                getUsersId
                                                    .add(getUsers[i]["id"]);
                                              });
                                            }
                                          }

                                          // setState(() {
                                          //   reassignMember = false;
                                          // });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(4),
                                          width: width,
                                          height: height * 0.05,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: getUsersName.contains(
                                                          getUsers[i]["name"])
                                                      ? GlobalColors.green
                                                      : GlobalColors
                                                          .themeColor2),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                                  "${getUsers[i]["name"]}")),
                                        ),
                                      )
                                ],
                              )),
                          Container(
                            width: width,
                            height: height * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    assignMember();
                                    setState(() {
                                      reassignMember = false;
                                      getUsersId = [];
                                      getUsers = [];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: GlobalColors.themeColor2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: width * 0.3,
                                    height: height * 0.04,
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.white,
                                            fontSize: width < 700
                                                ? width / 35
                                                : width / 45,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (isTimerOn) {
                                      Api()
                                          .publicBranchUsersReassign(
                                              ref.watch(newToken)!,
                                              ref.watch(publicTaskId),
                                              getUsersId)
                                          .then((value) {
                                        if (value.statusCode.toString() ==
                                            "422") {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.info,
                                            widget: Text(
                                              "${value.data["error"]["message"]}",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
                                            onConfirmBtnTap: () {},
                                            autoCloseDuration:
                                                Duration(seconds: 1),
                                          );
                                        } else {
                                          setState(() {
                                            reassignMember = false;
                                          });

                                          ref
                                              .read(pageIndex.notifier)
                                              .update((state) => 3);
                                        }
                                      });
                                    } else {
                                      assignMember();
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.info,
                                        widget: Text(
                                          "Please stop the timer to reassign members",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 48,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor2,
                                              letterSpacing: 0),
                                        ),
                                        onConfirmBtnTap: () {},
                                        autoCloseDuration:
                                            Duration(milliseconds: 1700),
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: GlobalColors.themeColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    width: width * 0.3,
                                    height: height * 0.04,
                                    child: Center(
                                      child: Text(
                                        "Reassign",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.white,
                                            fontSize: width < 700
                                                ? width / 35
                                                : width / 45,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (isLoading)
            Container(
              width: width,
              height: height,
              color: Color.fromARGB(81, 255, 255, 255),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
        ],
      ),
    );
  }
}

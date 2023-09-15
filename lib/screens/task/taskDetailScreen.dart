import 'dart:convert';

import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/expenses-screen.dart';
import 'package:credenze/screens/task/timeLogScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../const/global_colors.dart';
import 'commentScreen.dart';
import 'expensScreen.dart';
import 'overViewScreen.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen>
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
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  width: width,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 220, 220, 220),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (int) {
                          setState(() {
                            tabPage = int;
                          });
                        },
                        indicatorColor: GlobalColors.themeColor2,
                        labelColor: GlobalColors.white,
                        indicator: BoxDecoration(
                            color: GlobalColors.themeColor2,
                            borderRadius: BorderRadius.circular(5)),
                        controller: tabController,
                        unselectedLabelColor: GlobalColors.themeColor,
                        tabs: [
                          Tab(text: "Overview"),
                          Tab(text: "Comment"),
                          // Tab(text: "Time Logs"),
                          Tab(text: "Expense"),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: object.isEmpty
                        ? []
                        : [
                            if (tabPage == 0)
                              Container(
                                width: width,
                                height: height * 7,
                                child: OverViewScreen(),
                              ),
                            if (tabPage == 1)
                              Container(
                                width: width,
                                height: height * 0.7,
                                child: CommentScreen(
                                  isCompleted: isCompleted,
                                ),
                              ),
                            if (tabPage == 2)
                              object["is_with_expense"] == null
                                  ? Container(
                                      width: width,
                                      height: height * 0.7,
                                      child: Center(
                                        child: Text(
                                          "Its not Expense Task",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.themeColor,
                                              fontSize: width < 700
                                                  ? width / 35
                                                  : width / 45,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: width,
                                      height: height * 0.7,
                                      child: MainExpenseScreen(
                                        isCompleted: isCompleted,
                                      ),
                                    ),
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
                      height: height * 0.5,
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              width: width,
                              height: height * 0.4,
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
                                    setState(() {
                                      reassignMember = false;
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
                                    Api()
                                        .publicBranchUsersReassign(
                                            ref.watch(newToken)!,
                                            ref.watch(publicTaskId),
                                            getUsersId)
                                        .then((value) {
                                      setState(() {
                                        reassignMember = false;
                                      });

                                      ref
                                          .read(pageIndex.notifier)
                                          .update((state) => 3);
                                    });
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

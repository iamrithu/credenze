import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/dashboard-screen/widget/dashboardContainer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../apis/api.dart';
import '../../custom-widget/custom_alertbox.dart';
import '../../maps&location/map-location.dart';
import '../instalation-screen/tabs/widget/text-row-widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String bonus = "0";
  String presentList = "0";
  String achivement = "0";
  String absents = "0";
  bool isLocationEnable = true;

  List<Map<String, dynamic>> expenseList = [];
  String isChecked = "office";
  Map<String, dynamic> OBJ = {};
  bool catOption = false;
  String cat = "Petrol";
  bool isOpen = false;
  bool isOpenExpenseScreen = false;
  bool isOpen2 = false;
  File? newFile = null;

  bool isSubmit = false;
  String mileage = "";
  String amt = "";
  String msg = "";
  bool visible = false;
  bool success = false;
  bool isLoading = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  String _action = "DayIn";
  String? _dayIn;
  String? _dayOut;
  late Duration _loggedInHr;

  checkLocationActivity() async {
    await Geolocator.isLocationServiceEnabled().then((value) {
      setState(() {
        isLocationEnable = value;
      });
    });
  }

  getBonus() {
    Api().getBonus(ref.read(newToken)!).then((value) {
      setState(() {
        bonus = value.data["data"].toString();
      });
    });
  }

  getPresentList() {
    Api().getPresentList(ref.read(newToken)!).then((value) {
      setState(() {
        presentList = value.data["data"].toString();
      });
    });
  }

  getAchivement() {
    Api().getAchivement(ref.read(newToken)!).then((value) {
      setState(() {
        achivement = value.data["data"].toString();
      });
    });
  }

  getAbsents() {
    Api().getAbsentList(ref.read(newToken)!).then((value) {
      setState(() {
        absents = value.data["data"].toString();
      });
    });
  }

  attendenceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    Api().todayLogin(token).then((value) {
      if (value.data["message"]["attendance"].length == 0) {
        setState(() {
          _dayIn = null;
          _dayOut = null;
        });
        print("demo1");
      } else {
        for (var i = 0; i < value.data["message"]["attendance"].length; i++) {
          setState(() {
            if (value.data["message"]["attendance"][i]["clock_out_time"] ==
                null) {
              _dayIn = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][0]["clock_in_time"])
                  .toLocal());
              _dayOut =
                  value.data["message"]["attendance"][i]["clock_out_time"];
              _action = "DayOut";
              DateTime dt2 = DateTime.parse(
                      value.data["message"]["attendance"][0]["clock_in_time"])
                  .toLocal();

              DateTime dt1 = DateTime.now();
              Duration diff = dt1.difference(dt2);
              _loggedInHr = diff;

              print(DateTime.now().toString());
              print(_dayIn);

              print(dt2.toString());
              _stopWatchTimer.onStopTimer();
              _stopWatchTimer.clearPresetTime();
              // _stopWatchTimer.onResetTimer();

              _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
              _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
              _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
              _stopWatchTimer.onStartTimer();
            } else {
              _dayIn = "--/--";
              _dayOut = "--/--";
              _dayIn = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][0]["clock_in_time"])
                  .toLocal());
              _dayOut = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_out_time"])
                  .toLocal());
              // _action = "DayIn";
              // DateTime dt2 = DateTime.parse(
              //         value.data["message"]["attendance"][i]["clock_in_time"])
              //     .toLocal();
              // DateTime dt1 = DateTime.parse(
              //         value.data["message"]["attendance"][i]["clock_out_time"])
              //     .toLocal();
              // Duration diff = dt1.difference(dt2);
              // _stopWatchTimer.clearPresetTime();
              // _stopWatchTimer.onResetTimer();
              // _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
              // _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
              // _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
              // _stopWatchTimer.onStopTimer();
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLocationActivity();
    attendenceDetails();
    getBonus();
    getPresentList();
    getAchivement();
    getAbsents();
    // setState(() {
    //   expenseList = ref.read(TaskListPRovider);
    // });
    // setStoredDate();
    // _startLocation();
  }

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    dayIn() async {
      checkLocationActivity();
      if (!isLocationEnable) {
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: "Location service disabled",
          confirmBtnText: "Ok",
          autoCloseDuration: null,
        );
      }
      setState(() {
        isLoading = true;
      });
      Position? pos = await MapsAndLocation().locationPermisson();

      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');

      Api()
          .DayIn(token!, pos.toJson()["latitude"].toString(),
              pos.toJson()["longitude"].toString())
          .then((value) async {
        if (value.data["success"]) {
          setState(() {
            _action = "DayOut";
            visible = true;
            success = value.data["success"];
            msg = value.data["data"];
            _dayOut = null;
            isLoading = false;
          });
          attendenceDetails();

          Api().todayLogin(token).then((value) {
            if (value.data["message"]["attendance"].length > 0) {
              DateTime dt2 = DateTime.parse(
                      value.data["message"]["attendance"][0]["clock_in_time"])
                  .toLocal();

              DateTime dt1 = DateTime.now();
              Duration diff = dt1.difference(dt2);
              _loggedInHr = diff;

              _stopWatchTimer.onStopTimer();
              _stopWatchTimer.clearPresetTime();
              // _stopWatchTimer.onResetTimer();

              _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
              _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
              _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
              _stopWatchTimer.onStartTimer();
            }
          });
          setState(() {
            _action = "DayOut";
            visible = true;
            success = value.data["success"];
            msg = value.data["data"];
            _dayOut = null;
            isLoading = false;
          });

          if (visible) {
            setState(() {
              visible = false;
              success = false;
              isLoading = false;
            });
          }
        } else {
          attendenceDetails();
          setState(() {
            _action = "DayIn";
            visible = true;
            success = value.data["success"];
            msg = value.data["message"];
            isLoading = true;
          });
          if (visible) {
            setState(() {
              visible = false;
              success = false;
              isLoading = false;
            });
          }
        }
      });
    }

    dayOut() async {
      setState(() {
        isLoading = true;
      });
      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      Position? pos = await MapsAndLocation().locationPermisson();

      Api().CheckCanSubmit(token: token).then((value) {
        if (jsonDecode(value)["success"] == false) {
          setState(() {
            _action = "DayOut";
            isLoading = false;
          });

          return QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            title: jsonDecode(value)["message"],
            confirmBtnText: "Ok",
            autoCloseDuration: null,
          );
        }
        if (jsonDecode(value)["message"]["ask_expense"] == "YES") {
          setState(() {
            isOpen = true;
            OBJ = jsonDecode(value);
          });
          return null;
        }
        if (_loggedInHr.inHours.abs() < 10) {
          setState(() {
            isLoading = true;
          });
          QuickAlert.show(
            barrierDismissible: false,
            context: context,
            type: QuickAlertType.error,
            title: "Are you sure to day out",
            confirmBtnText: "Ok",
            cancelBtnText: "Cancel",
            showCancelBtn: true,
            autoCloseDuration: null,
            onCancelBtnTap: () {
              setState(() {
                isLoading = true;
                _action = "DayOut";
                isLoading = false;
              });
              Navigator.pop(context);
            },
            onConfirmBtnTap: () async {
              Navigator.pop(context);

              // Position? pos = await MapsAndLocation().locationPermisson();

              Api()
                  .DayOut(token!, pos.toJson()["latitude"].toString(),
                      pos.toJson()["longitude"].toString())
                  .then((value) async {
                print(value.toString());
                if (value.data["success"]) {
                  setState(() {
                    _action = "DayIn";
                    visible = true;
                    isLoading = false;
                    success = value.data["success"];
                    msg = value.data["data"];
                  });
                  attendenceDetails();

                  setState(() {
                    _dayIn = "--/--";
                    _dayOut = "--/--";
                  });
                  if (visible) {
                    setState(() {
                      visible = false;
                      success = false;
                    });
                  }
                } else {
                  attendenceDetails();
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.info,
                    title: value.data["message"],
                    confirmBtnText: "Ok",
                    autoCloseDuration: null,
                  );
                  setState(() {
                    _action = "DayOut";
                    visible = true;
                    success = value.data["success"];
                    msg = value.data["message"];
                    isLoading = false;
                  });
                  if (visible) {
                    setState(() {
                      visible = false;
                      success = false;
                    });
                  }
                }
              });
            },
          );
          return null;
        }

        Api()
            .DayOut(token!, pos.toJson()["latitude"].toString(),
                pos.toJson()["longitude"].toString())
            .then((value) async {
          if (value.data["success"]) {
            setState(() {
              _action = "DayIn";

              visible = true;
              success = value.data["success"];
              msg = value.data["data"];
              isLoading = false;
            });
            attendenceDetails();
            // setState(() {
            //   _dayIn = "--/--";
            //   _dayOut = "--/--";
            // });
            if (visible) {
              Timer(const Duration(milliseconds: 1500), () {
                setState(() {
                  visible = false;
                  success = false;
                });
              });
            }
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              title: value.data["message"],
              confirmBtnText: "Ok",
              autoCloseDuration: null,
            );
            attendenceDetails();

            setState(() {
              isLoading = false;
              visible = true;
              success = value.data["success"];
              msg = value.data["message"];
            });
            if (visible) {
              setState(() {
                _action = "DayOut";
                visible = false;
                success = false;
              });
            }
          }
        });
      });
    }

    action(GlobalKey<SlideActionState> key) {
      if (_action != "DayOut") {
        dayIn();
      } else {
        dayOut();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: width,
              height: width < 700 ? height * 0.8 : height * 0.86,
              child: LayoutBuilder(builder: ((context, constraints) {
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: height * 0.08,
                          child: Stack(
                            children: [
                              Container(
                                width: width,
                                height: height * 0.8,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.03,
                                              top: height * 0.01),
                                          child: Text(
                                            "WELCOME ",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 40,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor2,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                              left: width * 0.03,
                                            ),
                                            child: Consumer(
                                              builder: ((context, ref, child) {
                                                final data =
                                                    ref.watch(userDataProvider);

                                                return data.when(
                                                    data: (_data) {
                                                      ref
                                                          .read(userId.notifier)
                                                          .update((state) =>
                                                              _data.id!);
                                                      return Text(
                                                        _data.name!,
                                                        style: GoogleFonts.ptSans(
                                                            fontSize: width <
                                                                    700
                                                                ? width / 20
                                                                : width / 40,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: GlobalColors
                                                                .themeColor,
                                                            letterSpacing: 0),
                                                      );
                                                    },
                                                    error: (err, s) => Text(
                                                        "Not authenticated to perform this request"),
                                                    loading: () => const Center(
                                                          child:
                                                              CircularProgressIndicator
                                                                  .adaptive(),
                                                        ));
                                              }),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width,
                                height: height * 0.1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomAlertBox(
                                        success: success,
                                        visible: visible,
                                        width: width,
                                        height: height,
                                        msg: msg),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            width: width,
                            height: height * 0.14,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                CardContainer(
                                  title: "Target Achieved",
                                  value: achivement + "%",
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CardContainer(
                                  title: "Bonus Earned",
                                  value: bonus,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CardContainer(
                                  title: "Present",
                                  value: presentList + "\ndays",
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                CardContainer(
                                  title: "Absent",
                                  value: absents + "\ndays",
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                              vertical: height * 0.01),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 247, 247, 247),
                                    Color.fromARGB(255, 252, 227, 226),
                                  ],
                                  stops: [0, 1],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                            width: width,
                            height: constraints.maxHeight * 0.15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today's Status ",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 28
                                              : width / 48,
                                          fontWeight: FontWeight.w500,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 2,
                                  thickness: 1,
                                  color: GlobalColors.white,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Day In",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 25
                                                    : width / 24,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor,
                                                letterSpacing: 0),
                                          ),
                                          Text(
                                            _dayIn ?? "--/--",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 28
                                                    : width / 25,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.black,
                                                letterSpacing: 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Day Out",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 28
                                                    : width / 24,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor,
                                                letterSpacing: 0),
                                          ),
                                          Text(
                                            _dayOut ?? "--/--",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 25
                                                    : width / 23,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.black,
                                                letterSpacing: 0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  left: width * 0.03, top: width * 0.02),
                              child: RichText(
                                text: TextSpan(
                                    text: DateTime.now().day.toString(),
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 22
                                            : width / 22,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.themeColor,
                                        letterSpacing: 0),
                                    children: [
                                      TextSpan(
                                        text: " " +
                                            DateFormat("MMMM yyyy")
                                                .format(DateTime.now()),
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 24
                                                : width / 45,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.black,
                                            letterSpacing: 0),
                                      ),
                                    ]),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  left: width * 0.03,
                                  top: width * 0.03,
                                  right: width * 0.03),
                              child: StreamBuilder(
                                  stream: Stream.periodic(
                                      const Duration(seconds: 1)),
                                  builder: (context, snapshot) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: width * 0.03),
                                      child: Text(
                                        DateFormat("hh:mm:ss a")
                                            .format(DateTime.now()),
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 24
                                                : width / 45,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.black,
                                            letterSpacing: 0),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        // if (_action == "DayOut")
                        //   Card(
                        //     margin: EdgeInsets.symmetric(
                        //         horizontal: width * 0.025,
                        //         vertical: height * 0.02),
                        //     elevation: 10,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(width * 0.5),
                        //       // side: BorderSide(
                        //       //     color: GlobalColors.themeColor, width: 2),
                        //     ),
                        //     child: Container(
                        //       width: width < 500 ? width * 0.35 : width * 0.3,
                        //       height: width < 500 ? width * 0.35 : width * 0.3,
                        //       decoration: BoxDecoration(
                        //           borderRadius:
                        //               BorderRadius.circular(width * 0.5),
                        //           gradient: LinearGradient(
                        //             colors: [
                        //               Color.fromARGB(255, 247, 247, 247),
                        //               Color.fromARGB(255, 252, 227, 226),
                        //             ],
                        //             stops: [0, 1],
                        //             begin: Alignment.topCenter,
                        //             end: Alignment.bottomCenter,
                        //           )),
                        //       child: Center(
                        //           child: StreamBuilder(
                        //         stream: _stopWatchTimer.rawTime,
                        //         initialData: _stopWatchTimer.rawTime.value,
                        //         builder: ((context, snapshot) {
                        //           final value = snapshot.data;
                        //           final displayTimeWithoutSec =
                        //               StopWatchTimer.getDisplayTime(value!,
                        //                   hours: true,
                        //                   minute: true,
                        //                   second: false,
                        //                   milliSecond: false);
                        //           final displayTimeWithSec =
                        //               StopWatchTimer.getDisplayTime(value,
                        //                   hours: false,
                        //                   minute: false,
                        //                   second: true,
                        //                   milliSecond: false);
                        //           return Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               Text(
                        //                 "Logged In Time",
                        //                 style: GoogleFonts.ptSans(
                        //                     fontSize: width < 700
                        //                         ? width / 35
                        //                         : width / 48,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: GlobalColors.themeColor,
                        //                     letterSpacing: 0),
                        //               ),
                        //               Card(
                        //                 elevation: 10,
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius: BorderRadius.circular(
                        //                       width * 0.1),
                        //                 ),
                        //                 child: Padding(
                        //                   padding: EdgeInsets.all(width * 0.01),
                        //                   child: RichText(
                        //                     text: TextSpan(
                        //                         text: displayTimeWithoutSec
                        //                             .toString(),
                        //                         style: GoogleFonts.ptSans(
                        //                             fontSize: width < 700
                        //                                 ? width / 25
                        //                                 : width / 24,
                        //                             fontWeight: FontWeight.w400,
                        //                             color: GlobalColors
                        //                                 .themeColor2,
                        //                             letterSpacing: 2),
                        //                         children: [
                        //                           TextSpan(
                        //                             text: " " +
                        //                                 displayTimeWithSec
                        //                                     .toString(),
                        //                             style: GoogleFonts.ptSans(
                        //                                 fontSize: width < 700
                        //                                     ? width / 20
                        //                                     : width / 21,
                        //                                 fontWeight:
                        //                                     FontWeight.w400,
                        //                                 color: GlobalColors
                        //                                     .themeColor,
                        //                                 letterSpacing: 2),
                        //                           ),
                        //                         ]),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           );
                        //         }),
                        //       )),
                        //     ),
                        //   ),
                        if (!isLocationEnable)
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: height * 0.02),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  width: width,
                                  height: width < 700
                                      ? height * 0.08
                                      : height * 0.08,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: width * 0.4,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Enable your location",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 32
                                                  : width / 48,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: width * 0.2,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          onPressed: () {
                                            Geolocator.openLocationSettings();
                                          },
                                          child: Text(
                                            "Enable",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 35
                                                    : width / 42,
                                                fontWeight: FontWeight.w600,
                                                color: GlobalColors.white,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Container(
                                          width: width * 0.1,
                                          height: width * 0.1,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: GlobalColors.themeColor,
                                          ),
                                          alignment: Alignment.center,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.refresh,
                                              color: GlobalColors.white,
                                            ),
                                            onPressed: () {
                                              checkLocationActivity();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        if (isLocationEnable)
                          Builder(
                            builder: (context) {
                              final GlobalKey<SlideActionState> _key =
                                  GlobalKey();
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02,
                                    vertical: height * 0.02),
                                child: SlideAction(
                                  animationDuration:
                                      Duration(milliseconds: 500),
                                  reversed: _action != "DayIn" ? true : false,
                                  sliderButtonYOffset: 0,
                                  height: width < 700
                                      ? height * 0.08
                                      : height * 0.08,
                                  child: Text(
                                    _action == "DayIn"
                                        ? "Slide To Day In"
                                        : "Slide To Day Out",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 42,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                  borderRadius: 100,
                                  outerColor: GlobalColors.white,
                                  innerColor: _action == "DayIn"
                                      ? Colors.green
                                      : GlobalColors.themeColor,
                                  elevation: 1,
                                  key: _key,
                                  onSubmit: () {
                                    action(_key);
                                  },
                                ),
                              );
                            },
                          ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(children: [
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             CardContainer(
                        //               title: "Earning value",
                        //               value: bonus,
                        //             ),
                        //             CardContainer(
                        //               title: "Presence",
                        //               value: presentList+"\ndays",
                        //             ),
                        //             CardContainer(
                        //               title: "Absence",
                        //               value: absents+"\ndays",
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 8.0),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             CardContainer(
                        //               title: "Target Achieved",
                        //               value: achivement,
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ]),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                );
              })),
            ),
            if (isLoading)
              Container(
                width: width,
                height: width < 700 ? height * 0.8 : height * 0.86,
                color: Color.fromARGB(66, 251, 233, 233),
                child: Center(
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ),
            if (isOpen)
              Container(
                width: width,
                height: height,
                color: Color.fromARGB(255, 255, 255, 255),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        "You have to add expenses",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 22 : width / 48,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor2,
                            letterSpacing: 1),
                      ),
                      Expanded(
                        child: ListView(children: [
                          if (expenseList.isNotEmpty)
                            for (var i = 0; i < expenseList.length; i++)
                              Stack(
                                children: [
                                  Card(
                                      color: GlobalColors.themeColor,
                                      elevation: 10,
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        width: width * 0.9,
                                        height: height * 0.05,
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Card(
                                        elevation: 10,
                                        child: Container(
                                          margin: EdgeInsets.all(8),
                                          width: width * 0.86,
                                          height: height * 0.05,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6.0),
                                                child: TextRowWidget(
                                                  width: width,
                                                  lable: "Category",
                                                  value:
                                                      "${expenseList[i]["category_id"] == 1 ? "Petrol" : "Food"}",
                                                ),
                                              ),
                                              if (expenseList[i]
                                                      ["category_id"] ==
                                                  1)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0),
                                                  child: TextRowWidget(
                                                    width: width,
                                                    lable: "Distance",
                                                    value:
                                                        "${expenseList[i]["distance"]} Km",
                                                  ),
                                                ),
                                              if (expenseList[i]
                                                      ["category_id"] !=
                                                  1)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.0),
                                                  child: TextRowWidget(
                                                    width: width,
                                                    lable: "Amount",
                                                    value:
                                                        "${expenseList[i]["amount"]}",
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                        ]),
                      ),
                      Container(
                        width: width,
                        height: height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  expenseList = [];
                                  isLoading = false;
                                  isOpen = false;
                                  isOpen2 = false;
                                  _action = "DayOut";
                                });
                              },
                              child: Container(
                                color: GlobalColors.themeColor2,
                                width: width * 0.3,
                                height: height * 0.04,
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 40,
                                        fontWeight: FontWeight.w500,
                                        color: GlobalColors.white,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isOpenExpenseScreen = true;
                                });
                              },
                              child: Container(
                                color: GlobalColors.themeColor2,
                                width: width * 0.3,
                                height: height * 0.04,
                                child: Center(
                                  child: Text(
                                    "Add Expense",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 40,
                                        fontWeight: FontWeight.w500,
                                        color: GlobalColors.white,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Api()
                                    .addPublicExpense(
                                        ref.watch(newToken)!,
                                        OBJ["message"]["dep_type"],
                                        OBJ["message"]["reference_id"],
                                        expenseList)
                                    .then((value) {
                                  setState(() {
                                    isOpen = false;
                                    isOpen2 = false;
                                    isOpenExpenseScreen = false;
                                    expenseList = [];
                                  });
                                  dayOut();
                                });
                              },
                              child: Container(
                                color: GlobalColors.themeColor,
                                width: width * 0.3,
                                height: height * 0.04,
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 40,
                                        fontWeight: FontWeight.w500,
                                        color: GlobalColors.white,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (isOpenExpenseScreen)
              Container(
                width: width,
                height: height,
                color: Color.fromARGB(108, 0, 0, 0),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      child: Card(
                        elevation: 1,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListBody(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Container(
                                      width: width,
                                      color: GlobalColors.themeColor,
                                      child: Center(
                                        child: Text(
                                          "Add Expenses",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.white,
                                              fontSize: width < 700
                                                  ? width / 28
                                                  : width / 45,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      height: 40,
                                    ),
                                    Container(
                                      width: width,
                                      height: height * 0.06,
                                      child: Row(children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: width * 0.25,
                                          child: Text(
                                            "Category *",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 48,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.black,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: width * 0.05,
                                          child: Text(":"),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              catOption = true;
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                    color: GlobalColors
                                                        .themeColor2)),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: width * 0.5,
                                              height: height * 0.05,
                                              child: Center(
                                                child: Text(
                                                  "${cat}",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 30
                                                          : width / 48,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors.black,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    if (cat != "Food")
                                      Container(
                                        width: width,
                                        height: height * 0.1,
                                        child: Row(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.25,
                                            child: Text(
                                              "From Place *",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color: GlobalColors.black,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.05,
                                            child: Text(":"),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: GlobalColors
                                                          .themeColor2)),
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.centerLeft,
                                                width: width * 0.5,
                                                height: height * 1,
                                                child: Center(
                                                  child: Text(
                                                    "${OBJ["message"]["from_place"] ?? "--"}",
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: width < 700
                                                            ? width / 40
                                                            : width / 48,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            GlobalColors.black,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    if (cat != "Food")
                                      Container(
                                        width: width,
                                        height: height * 0.06,
                                        child: Row(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.25,
                                            child: Text(
                                              "To Place *",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color: GlobalColors.black,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.05,
                                            child: Text(":"),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                setState(() {
                                                  isOpen2 = true;
                                                });
                                              });
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: BorderSide(
                                                      color: GlobalColors
                                                          .themeColor2)),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                width: width * 0.5,
                                                height: height * 1,
                                                child: Center(
                                                  child: Text(
                                                    "${isChecked}",
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: width < 700
                                                            ? width / 34
                                                            : width / 48,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: GlobalColors
                                                            .themeColor2,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    if (cat != "Food")
                                      Container(
                                        width: width,
                                        child: Row(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.25,
                                            child: Text(
                                              "Distance *",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color: GlobalColors.black,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.05,
                                            child: Text(":"),
                                          ),
                                          Card(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: width * 0.5,
                                              child: TextFormField(
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 700
                                                        ? width / 30
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (e) {
                                                  return setState(() {
                                                    mileage = e;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    if (cat == "Food")
                                      Container(
                                        width: width,
                                        child: Row(children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.25,
                                            child: Text(
                                              "Amount *",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color: GlobalColors.black,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: width * 0.05,
                                            child: Text(":"),
                                          ),
                                          Card(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: width * 0.5,
                                              child: TextFormField(
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 700
                                                        ? width / 30
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                                onChanged: (e) {
                                                  return setState(() {
                                                    amt = e;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    Container(
                                      width: width,
                                      height: height * 0.06,
                                      child: Row(
                                        children: [
                                          Container(
                                              width: width * 0.23,
                                              height: height * 0.05,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  left: width * 0.01),
                                              child: Text(
                                                "File ",
                                                style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 44,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0,
                                                ),
                                              )),
                                          Container(
                                              width: width * 0.05,
                                              height: height * 0.05,
                                              alignment: Alignment.centerLeft,
                                              margin: EdgeInsets.only(
                                                  left: width * 0.01),
                                              child: Text(
                                                ":",
                                                style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 44,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0,
                                                ),
                                              )),
                                          Container(
                                            width: width * 0.32,
                                            height: height * 0.05,
                                            margin: EdgeInsets.only(
                                                left: 5, right: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: GlobalColors
                                                        .themeColor2)),
                                            child: Container(
                                              width: width * 0.2,
                                              padding: EdgeInsets.only(
                                                  left: width * 0.07),
                                              alignment: Alignment.centerLeft,
                                              child: newFile == null
                                                  ? Text(
                                                      "",
                                                      style: GoogleFonts.ptSans(
                                                        color: GlobalColors
                                                            .themeColor2,
                                                        fontSize: width < 700
                                                            ? width / 35
                                                            : width / 44,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0,
                                                      ),
                                                    )
                                                  : Text(newFile == null
                                                      ? ""
                                                      : "${newFile!.path.split('/').last}"),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          allowMultiple: true);
                                              if (result != null) {
                                                File file = File(
                                                    result.files.single.path!);
                                                setState(() {
                                                  newFile = file;
                                                });
                                              }
                                            },
                                            child: Container(
                                                width: width * 0.17,
                                                height: height * 0.05,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: GlobalColors
                                                            .themeColor2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Center(
                                                  child: Icon(
                                                      FontAwesomeIcons.file,
                                                      color: GlobalColors
                                                          .themeColor),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: height * 0.08,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isOpenExpenseScreen = false;
                                                expenseList = [];
                                              });
                                            },
                                            child: Container(
                                              color: GlobalColors.themeColor2,
                                              width: width * 0.4,
                                              height: height * 0.05,
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 30
                                                          : width / 40,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: GlobalColors.white,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (cat != "Petrol" &&
                                                  amt.trim().isEmpty) {
                                                QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.error,
                                                    title: "Enter Amount",
                                                    autoCloseDuration: null);
                                                return null;
                                              }
                                              if (cat == "Petrol" &&
                                                  mileage.trim().isEmpty) {
                                                QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.error,
                                                    title: "Enter Distance",
                                                    autoCloseDuration: null);
                                                return null;
                                              }
                                              Map<String, dynamic> datas = {
                                                "id": expenseList.length + 1,
                                                "category_id":
                                                    cat == "Petrol" ? 1 : 2,
                                                "from_place": cat == "Petrol"
                                                    ? OBJ["message"]
                                                        ["from_place"]
                                                    : "",
                                                "to_place": cat == "Petrol"
                                                    ? isChecked
                                                    : "",
                                                "distance": cat == "Petrol"
                                                    ? mileage
                                                    : "",
                                                "amount":
                                                    cat == "Petrol" ? 0 : amt,
                                                "notes": "--",
                                                "file": newFile ?? File(""),
                                              };

                                              setState(() {
                                                expenseList.add(datas);
                                                isOpenExpenseScreen = false;

                                                amt = "";
                                                mileage = "";
                                              });
                                              // print(OBJ.toString());

                                              // Api().addPublicExpense(
                                              //     ref.watch(newToken)!,
                                              //     OBJ["message"]["dep_type"],
                                              //     OBJ["message"]
                                              //         ["reference_id"],
                                              //     expenseList);

                                              // print(expenseList.toString());
                                            },
                                            child: Container(
                                              color: GlobalColors.themeColor,
                                              width: width * 0.4,
                                              height: height * 0.05,
                                              child: Center(
                                                child: Text(
                                                  "Add",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 30
                                                          : width / 40,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: GlobalColors.white,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isOpen2)
                      Container(
                        width: width,
                        height: height * 0.5,
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        color: Color.fromARGB(97, 0, 0, 0),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: width,
                            height: height * 0.2,
                            child: Column(children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = "home";
                                    isOpen2 = false;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    width: width,
                                    height: height * 0.05,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "home",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 40,
                                          fontWeight: FontWeight.w500,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isChecked = "office";
                                    isOpen2 = false;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    width: width,
                                    height: height * 0.05,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "office",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 40,
                                          fontWeight: FontWeight.w500,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    if (catOption)
                      Container(
                        width: width,
                        height: height * 0.5,
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        color: Color.fromARGB(97, 0, 0, 0),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: width,
                            height: height * 0.2,
                            child: Column(children: <Widget>[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    cat = "Petrol";
                                    catOption = false;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    width: width,
                                    height: height * 0.05,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Petrol",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 40,
                                          fontWeight: FontWeight.w500,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    cat = "Food";
                                    catOption = false;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    width: width,
                                    height: height * 0.05,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Food",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 40,
                                          fontWeight: FontWeight.w500,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/locations/location_service.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../apis/api.dart';
import '../../custom-widget/custom_alertbox.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String msg = "";
  bool visible = false;
  bool success = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  String _action = "DayIn";
  String? _dayIn;
  String? _dayOut;
  bool _dayCompleted = false;

  _startLocation() async {
    LocationService().initialize();
    LocationService().getLat().then((value) {});
  }

  attendenceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    Api().todayLogin(token).then((value) {
      if (value.data["message"]["attendance"].length == 0) {
        print(value.data["message"]["attendance"].length.toString());
        setState(() {
          _dayIn = null;
          _dayOut = null;
        });
      } else {
        for (var i = 0; i < value.data["message"]["attendance"].length; i++) {
          setState(() {
            if (value.data["message"]["attendance"][i]["clock_out_time"] ==
                null) {
              _dayIn = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_in_time"])
                  .toLocal());
              _dayOut =
                  value.data["message"]["attendance"][i]["clock_out_time"];
              _action = "DayOut";
              DateTime dt2 = DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_in_time"])
                  .toLocal();
              DateTime dt1 = DateTime.now();
              Duration diff = dt1.difference(dt2);

              _stopWatchTimer.onStopTimer();

              _stopWatchTimer.clearPresetTime();
              _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
              _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
              _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
              _stopWatchTimer.onStartTimer();
            } else {
              _dayIn = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_in_time"])
                  .toLocal());
              _dayOut = DateFormat("hh:mm:ss").format(DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_out_time"])
                  .toLocal());
              _action = "DayIn";
              DateTime dt2 = DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_in_time"])
                  .toLocal();
              DateTime dt1 = DateTime.parse(
                      value.data["message"]["attendance"][i]["clock_out_time"])
                  .toLocal();
              Duration diff = dt1.difference(dt2);
              _stopWatchTimer.clearPresetTime();
              _stopWatchTimer.onResetTimer();
              _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
              _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
              _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
              _stopWatchTimer.onStopTimer();
            }

            // if (_dayIn != null) {
            //   _action = "DayOut";

            // }

            // if (_dayOut != null) {
            //   _action = "DayIn";
          });
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attendenceDetails();
    // setStoredDate();
    // _startLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    dayIn() async {
      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      Api().clockIn(token).then((value) async {
        if (value.data["success"]) {
          setState(() {
            _action = "DayOut";
            visible = true;
            success = value.data["success"];
            // _dayIn = DateFormat("hh:mm:ss a").format(DateTime.now()).toString();
            msg = value.data["data"];
            _dayOut = null;
          });
          attendenceDetails();

          // await prefs.setString('dayIn', _dayIn.toString());
          // await prefs.setString('dayOut', "");
          _stopWatchTimer.clearPresetTime();
          // _stopWatchTimer.onStartTimer();
          // _stopWatchTimer.setPresetHoursTime(0);
          // _stopWatchTimer.setPresetMinuteTime(0);
          // _stopWatchTimer.setPresetSecondTime(0);
          if (visible) {
            Timer(const Duration(milliseconds: 1500), () {
              setState(() {
                visible = false;
                success = false;
              });
            });
          }
        } else {
          attendenceDetails();
          setState(() {
            _action = "DayIn";
            visible = true;
            success = value.data["success"];
            msg = value.data["message"];
          });
          if (visible) {
            Timer(const Duration(milliseconds: 1500), () {
              setState(() {
                visible = false;
                success = false;
              });
            });
          }
        }
      });
    }

    dayOut() async {
      final prefs = await SharedPreferences.getInstance();
      String? token = await prefs.getString('token');
      Api().ClockOut(token).then((value) async {
        if (value.data["success"]) {
          setState(() {
            _action = "DayIn";
            // _dayCompleted = true;
            visible = true;
            // _dayOut =
            //     DateFormat("hh:mm:ss a").format(DateTime.now()).toString();
            success = value.data["success"];
            msg = value.data["data"];
          });

          // await prefs.setString('dayOut', _dayOut.toString());

          // _stopWatchTimer.onStopTimer();
          attendenceDetails();

          if (visible) {
            Timer(const Duration(milliseconds: 1500), () {
              setState(() {
                visible = false;
                success = false;
              });
            });
          }
          // Api().attdToday(token).then((value) {
          //  if(value.data["message"]["remaining_clock_in"]==0){
          //   setState(() {

          //   });
          //  }
          // });
        } else {
          attendenceDetails();
          setState(() {
            _action = "DayIn";
            _dayCompleted = false;
            visible = true;
            success = value.data["success"];
            msg = value.data["message"];
          });

          if (visible) {
            Timer(const Duration(milliseconds: 1500), () {
              setState(() {
                visible = false;
                success = false;
              });
            });
          }
        }
      });
    }

    action() {
      if (_action != "DayOut") {
        dayIn();
      } else {
        dayOut();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.03,
                                          top: height * 0.01),
                                      child: Text(
                                        "WELCOME ",
                                        style: GoogleFonts.abel(
                                            fontSize: width < 700
                                                ? width / 27
                                                : width / 40,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor2,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                                  return Text(
                                                    _data.name!,
                                                    style: GoogleFonts.abel(
                                                        fontSize: width < 700
                                                            ? width / 17
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
                    Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.025, vertical: height * 0.01),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: GlobalColors.themeColor),
                      ),
                      child: Container(
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
                                  style: GoogleFonts.abel(
                                      fontSize:
                                          width < 700 ? width / 21 : width / 48,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.textColor,
                                      letterSpacing: 0),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2,
                              thickness: 1,
                              color: GlobalColors.themeColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Day In ",
                                        style: GoogleFonts.abel(
                                            fontSize: width < 700
                                                ? width / 18
                                                : width / 24,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor,
                                            letterSpacing: 0),
                                      ),
                                      Text(
                                        _dayIn ?? "--/--",
                                        style: GoogleFonts.abel(
                                            fontSize: width < 700
                                                ? width / 17
                                                : width / 23,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor2,
                                            letterSpacing: 0),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Day Out ",
                                        style: GoogleFonts.abel(
                                            fontSize: width < 700
                                                ? width / 18
                                                : width / 24,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor,
                                            letterSpacing: 0),
                                      ),
                                      Text(
                                        _dayOut ?? "--/--",
                                        style: GoogleFonts.abel(
                                            fontSize: width < 700
                                                ? width / 17
                                                : width / 23,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor2,
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
                                style: GoogleFonts.abel(
                                    fontSize:
                                        width < 700 ? width / 16 : width / 22,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.themeColor,
                                    letterSpacing: 2),
                                children: [
                                  TextSpan(
                                    text: " " +
                                        DateFormat("MMMM yyyy")
                                            .format(DateTime.now()),
                                    style: GoogleFonts.abel(
                                        fontSize: width < 700
                                            ? width / 22
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 2),
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
                              stream:
                                  Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: width * 0.03),
                                  child: Text(
                                    DateFormat("hh:mm:ss a")
                                        .format(DateTime.now()),
                                    style: GoogleFonts.abel(
                                        fontSize: width < 700
                                            ? width / 22
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 2),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.025, vertical: height * 0.02),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.1),
                          side: BorderSide(
                              color: GlobalColors.themeColor, width: 2)),
                      child: Container(
                        width: width < 500 ? width * 0.4 : width * 0.3,
                        height: width < 500 ? width * 0.4 : width * 0.3,
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
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Logged In Time",
                                  style: GoogleFonts.abel(
                                      fontSize:
                                          width < 700 ? width / 28 : width / 42,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.black,
                                      letterSpacing: 0),
                                ),
                                Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(width * 0.02),
                                    child: RichText(
                                      text: TextSpan(
                                          text:
                                              displayTimeWithoutSec.toString(),
                                          style: GoogleFonts.abel(
                                              fontSize: width < 700
                                                  ? width / 20
                                                  : width / 24,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor2,
                                              letterSpacing: 2),
                                          children: [
                                            TextSpan(
                                              text: " " +
                                                  displayTimeWithSec.toString(),
                                              style: GoogleFonts.abel(
                                                  fontSize: width < 700
                                                      ? width / 12
                                                      : width / 18,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor,
                                                  letterSpacing: 2),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        )),
                      ),
                    ),
                    !_dayCompleted
                        ? Builder(
                            builder: (context) {
                              final GlobalKey<SlideActionState> _key =
                                  GlobalKey();
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.03,
                                    vertical: height * 0.03),
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
                                    style: GoogleFonts.abel(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 42,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.white,
                                        letterSpacing: 0),
                                  ),
                                  borderRadius: 100,
                                  outerColor: GlobalColors.themeColor,
                                  innerColor: GlobalColors.white,
                                  elevation: 10,
                                  key: _key,
                                  onSubmit: () {
                                    Future.delayed(Duration(seconds: 1), () {
                                      _key.currentState!.reset();
                                      action();
                                    });
                                  },
                                ),
                              );
                            },
                          )
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                            child: Card(
                                margin: EdgeInsets.only(top: height * 0.026),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: GlobalColors.themeColor)),
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  width: width,
                                  height: constraints.maxHeight * 0.12,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "YOU HAVE DONE A GOOD JOB TODAY 🤝🤝🤝",
                                    style: GoogleFonts.abel(
                                        fontSize: width < 700
                                            ? width / 22
                                            : width / 48,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 1),
                                  ),
                                )),
                          ),
                  ],
                ),
              ),
            );
          })),
        ),
      ),
    );
  }
}

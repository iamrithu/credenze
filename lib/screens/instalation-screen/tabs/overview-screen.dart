import 'dart:convert';
import 'dart:io';

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../apis/api.dart';
import '../../../const/global_colors.dart';
import '../../../maps&location/map-location.dart';

class OverviewScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const OverviewScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends ConsumerState<OverviewScreen> {
  double lat = 0.0;
  double long = 0.0;
  bool detailVisible = false;
  bool loading = false;
  String? clockInlat = "";
  String? clockInlong = "";
  String? clockOutlat = "";
  String? clockOutlong = "";
  String? clockInAddress = "";
  String? clockOutAddress = "";

  String? attendanceDetail = "ClockInDetail";
  List<String> allowFolowUp = ["ClockInDetail", "ClockOutDetail"];
  final List<bool> _allowFollowUp = <bool>[
    true,
    false,
  ];

  late String? clockIn = null;
  late String? clockOut = null;
  bool installationComplete = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late File? newImage = null;

  getclockInAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    setState(() {
      clockInAddress =
          "${placemarks[0].street},${placemarks[0].thoroughfare},${placemarks[0].locality},${placemarks[0].administrativeArea},${placemarks[0].postalCode},${placemarks[0].country}";
    });
  }

  getclockOutAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print("rithi not null");

    setState(() {
      clockOutAddress =
          "${placemarks[0].street},${placemarks[0].thoroughfare},${placemarks[0].locality},${placemarks[0].administrativeArea},${placemarks[0].postalCode},${placemarks[0].country}";
    });
  }

  getInstallationAttendence() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    final id = ref.watch(overViewId);
    Api().InstallationAttendence(token!, id).then((value) {
      print(value.data["data"].length.toString());

      List data = value.data["data"];
      if (data.isEmpty) {
        setState(() {
          clockIn = null;
          clockOut = null;
        });
      } else {
        var newdata = data
            .firstWhere(((element) => element["user_id"] == ref.watch(userId)));

        if (newdata["clock_in"] == null) {
          ref.read(InstallationClockIn.notifier).update((state) => true);
        } else {
          ref.read(InstallationClockIn.notifier).update((state) => false);

          setState(() {
            clockIn = DateFormat("hh:mm:ss a")
                .format(DateTime.parse(newdata["clock_in"]).toLocal());
            detailVisible = true;
            clockInlat = newdata["latitude"];
            clockInlong = newdata["longitude"];
            getclockInAddress(
                double.parse(clockInlat!), double.parse(clockInlong!));
          });
        }
        if (newdata["clock_out"] == null) {
          setState(() {
            clockOut = null;
          });
          DateTime dt2 = DateTime.parse(newdata["clock_in"]).toLocal();
          DateTime dt1 = DateTime.now();
          Duration diff = dt1.difference(dt2);

          _stopWatchTimer.onStopTimer();

          _stopWatchTimer.clearPresetTime();
          _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
          _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
          _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
          _stopWatchTimer.onStartTimer();
        } else {
          setState(() {
            installationComplete = true;
            clockOut = DateFormat("hh:mm:ss a")
                .format(DateTime.parse(newdata["clock_out"]).toLocal());

            clockOutlat = newdata["clock_out_latitude"];
            clockOutlong = newdata["clock_out_longitude"];
          });
          if (clockOutlat == null || clockOutlong == null) {
            setState(() {
              clockOutAddress = null;
            });
          } else {
            getclockOutAddress(
                double.parse(clockOutlat!), double.parse(clockOutlong!));
          }

          ref.read(InstallationClockIn.notifier).update((state) => true);
          DateTime dt2 = DateTime.parse(newdata["clock_in"]).toLocal();
          DateTime dt1 = DateTime.parse(newdata["clock_out"]).toLocal();
          Duration diff = dt1.difference(dt2);

          _stopWatchTimer.clearPresetTime();
          _stopWatchTimer.onResetTimer();
          _stopWatchTimer.setPresetHoursTime(diff.inHours % 24.abs());
          _stopWatchTimer.setPresetMinuteTime(diff.inMinutes % 60.abs());
          _stopWatchTimer.setPresetSecondTime(diff.inSeconds % 60.abs());
          _stopWatchTimer.onStopTimer();
        }
      }
    });

    setState(() {
      loading = false;
    });
  }

  installationClockIn(int? id) async {
    setState(() {
      loading = true;
      detailVisible = true;
    });
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    MapsAndLocation().getCamera().then((value) {
      setState(() {
        newImage = value;
      });
      MapsAndLocation().locationPermisson().then((value) {
        setState(() {
          lat = value.latitude;
          long = value.longitude;
        });
        Api()
            .ClockIn(
                token: token!,
                id: id!,
                latitude: lat.toString(),
                longitude: long.toString(),
                photo: newImage!)
            .then((value) {
          Map<String, dynamic> data = jsonDecode(value);
          if (data["success"]) {
            getInstallationAttendence();
          } else {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: "${data["message"]}",
                autoCloseDuration: null);

            setState(() {
              loading = false;
              detailVisible = false;
            });
          }
        });
      });
    });
  }

  installationClockOut(int? id) async {
    setState(() {
      loading = true;
      detailVisible = true;
    });
    final prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('token');
    MapsAndLocation().locationPermisson().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      Api()
          .ClockOut(
              token: token!,
              id: id!,
              latitude: value.latitude.toString(),
              longitude: value.longitude.toString())
          .then((value) {
        Map<String, dynamic> data = jsonDecode(value);
        if (data["success"]) {
          getInstallationAttendence();
        } else {
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "${data["message"]}",
              autoCloseDuration: null);
          setState(() {
            loading = false;
            detailVisible = false;
          });
        }
      });
    });
  }

  @override
  void initState() {
    getInstallationAttendence();

    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final installation = ref.watch(InsttalationOverVIewProvider);
    final instalationClockIn = ref.watch(InstallationClockIn);
    int? id = ref.watch(overViewId);
    print("overViewId" + id.toString());
    return installation.when(
        data: (_data) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: GlobalColors.themeColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                return ref.refresh(InsttalationOverVIewProvider);
              });
            },
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Container(
                        width: widget.width,
                        height: widget.height! * 0.2,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: GlobalColors.themeColor2),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: widget.width! * 0.3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: installationComplete
                                          ? null
                                          : !instalationClockIn
                                              ? null
                                              : () {
                                                  installationClockIn(id);
                                                },
                                      child: Text(
                                        "Clock In ",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.ptSans(
                                            fontSize: widget.width! < 700
                                                ? widget.width! / 24
                                                : widget.width! / 42,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.white,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                    Container(
                                      width: widget.width! * 0.25,
                                      child: Card(
                                        elevation: 4,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              clockIn == null
                                                  ? "--/--/--"
                                                  : "$clockIn",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.ptSans(
                                                  fontSize: widget.width! < 700
                                                      ? widget.width! / 35
                                                      : widget.width! / 42,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: widget.height! * 0.13,
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Working Time",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.ptSans(
                                              fontSize: widget.width! < 700
                                                  ? widget.width! / 35
                                                  : widget.width! / 45,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor,
                                              letterSpacing: 0),
                                        ),
                                        StreamBuilder(
                                          stream: _stopWatchTimer.rawTime,
                                          initialData:
                                              _stopWatchTimer.rawTime.value,
                                          builder: ((context, snapshot) {
                                            final value = snapshot.data;
                                            final displayTimeWithoutSec =
                                                StopWatchTimer.getDisplayTime(
                                                    value!,
                                                    hours: true,
                                                    minute: true,
                                                    second: false,
                                                    milliSecond: false);
                                            final displayTimeWithSec =
                                                StopWatchTimer.getDisplayTime(
                                                    value,
                                                    hours: false,
                                                    minute: false,
                                                    second: true,
                                                    milliSecond: false);
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                  widget.width! * 0.01),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: displayTimeWithoutSec
                                                        .toString(),
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: widget
                                                                    .width! <
                                                                700
                                                            ? widget.width! / 33
                                                            : widget.width! /
                                                                24,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: GlobalColors
                                                            .themeColor2,
                                                        letterSpacing: 0),
                                                    children: [
                                                      TextSpan(
                                                        text: " " +
                                                            displayTimeWithSec
                                                                .toString(),
                                                        style: GoogleFonts.ptSans(
                                                            fontSize: widget
                                                                        .width! <
                                                                    700
                                                                ? widget.width! /
                                                                    33
                                                                : widget.width! /
                                                                    18,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: GlobalColors
                                                                .themeColor,
                                                            letterSpacing: 0),
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: widget.width! * 0.3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: installationComplete
                                          ? null
                                          : instalationClockIn
                                              ? null
                                              : () {
                                                  installationClockOut(id);
                                                },
                                      child: Text(
                                        "Clock Out",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.ptSans(
                                            fontSize: widget.width! < 700
                                                ? widget.width! / 24
                                                : widget.width! / 42,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.white,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                    Container(
                                      width: widget.width! * 0.25,
                                      child: Card(
                                        elevation: 4,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              clockOut == null
                                                  ? "--/--/--"
                                                  : "$clockOut",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.ptSans(
                                                  fontSize: widget.width! < 700
                                                      ? widget.width! / 35
                                                      : widget.width! / 42,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
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
                      Container(
                        width: widget.width,
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: GlobalColors.themeColor2),
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: widget.width! * 0.74,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: GlobalColors
                                                          .themeColor),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              elevation: 5,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "Installation Overview",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 35
                                                          : widget.width! / 42,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "InstallationCode",
                                          value:
                                              "${_data.installationPrefix}${_data.installationNos}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Installation Name",
                                          value: "${_data.installationName}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Branch Name",
                                          value: "${_data.branchId}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Customer Name",
                                          value: "${_data.customerName}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Installation Site",
                                          value: "${_data.customerAddress}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Installation Start Date",
                                          value:
                                              "${DateFormat("dd - MMMM - yyyy ").format(_data.startDate!)}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Installation Summary",
                                          value:
                                              "${_data.installationSummary == null ? "--" : _data.installationSummary.replaceAll("<p>", "").replaceAll("</p>", "")}",
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: widget.width! * 0.16,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            MapsAndLocation().openMapsSheet(
                                                context,
                                                double.parse(
                                                    _data.siteLatitude!),
                                                double.parse(
                                                    _data.siteLongitude!));
                                          },
                                          child: Container(
                                            width: widget.width! * 0.1,
                                            child: Card(
                                              margin: EdgeInsets.all(2),
                                              elevation: 4,
                                              child: Image(
                                                image: AssetImage(
                                                    "Assets/images/map.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Visibility(
                        visible: detailVisible,
                        child: Container(
                          width: widget.width,
                          height: widget.height! * 0.4,
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: GlobalColors.themeColor2),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: widget.width! * 0.6,
                                            alignment:
                                                AlignmentDirectional.center,
                                            child: ToggleButtons(
                                              direction: Axis.horizontal,
                                              onPressed: (int index) {
                                                setState(() {
                                                  // The button that is tapped is set to true, and the others to false.
                                                  for (int i = 0;
                                                      i < _allowFollowUp.length;
                                                      i++) {
                                                    _allowFollowUp[i] =
                                                        i == index;
                                                  }
                                                  allowFolowUp[index];
                                                  setState(() {
                                                    attendanceDetail =
                                                        allowFolowUp[index];
                                                  });
                                                });
                                              },
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(4)),
                                              selectedBorderColor:
                                                  Colors.red[700],
                                              selectedColor: Colors.white,
                                              fillColor:
                                                  GlobalColors.themeColor,
                                              color: GlobalColors.themeColor2,
                                              constraints: BoxConstraints(
                                                minHeight:
                                                    widget.height! * 0.05,
                                                minWidth: 80.0,
                                              ),
                                              isSelected: _allowFollowUp,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Text(
                                                    "Clock In Detail",
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: widget
                                                                    .width! <
                                                                700
                                                            ? widget.width! / 35
                                                            : widget.width! /
                                                                42,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Text(
                                                    "Clock Out Detail",
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: widget
                                                                    .width! <
                                                                700
                                                            ? widget.width! / 35
                                                            : widget.width! /
                                                                42,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      attendanceDetail == "ClockInDetail"
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: widget.width! * 0.4,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.network(
                                                          "http://15.207.1.213/user-uploads/installation-dayin/27b09ed8d04037aa66864a39e79c1306.png",
                                                          width: widget.width! *
                                                              0.3,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: widget.width! * 0.4,
                                                  height: widget.height! * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              "Clock In Time :",
                                                          style: GoogleFonts.ptSans(
                                                              fontSize: widget
                                                                          .width! <
                                                                      700
                                                                  ? widget.width! /
                                                                      35
                                                                  : widget.width! /
                                                                      42,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: GlobalColors
                                                                  .themeColor2,
                                                              letterSpacing: 0),
                                                          children: [
                                                            TextSpan(
                                                              text: "$clockIn",
                                                              style: GoogleFonts.ptSans(
                                                                  fontSize: widget
                                                                              .width! <
                                                                          700
                                                                      ? widget.width! /
                                                                          35
                                                                      : widget.width! /
                                                                          42,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      GlobalColors
                                                                          .black,
                                                                  letterSpacing:
                                                                      0),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "Address :",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts.ptSans(
                                                            fontSize: widget
                                                                        .width! <
                                                                    700
                                                                ? widget.width! /
                                                                    35
                                                                : widget.width! /
                                                                    42,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: GlobalColors
                                                                .themeColor2,
                                                            letterSpacing: 0),
                                                      ),
                                                      Text(
                                                        "${clockInAddress}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: GoogleFonts.ptSans(
                                                            fontSize: widget
                                                                        .width! <
                                                                    700
                                                                ? widget.width! /
                                                                    35
                                                                : widget.width! /
                                                                    42,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                !installationComplete
                                                    ? Center(
                                                        child: Text(
                                                          "Clock Out Detail Not Available ...",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: GoogleFonts.ptSans(
                                                              fontSize: widget.width! <
                                                                      700
                                                                  ? widget.width! /
                                                                      35
                                                                  : widget.width! /
                                                                      42,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  GlobalColors
                                                                      .black,
                                                              letterSpacing: 0),
                                                        ),
                                                      )
                                                    : Container(
                                                        width:
                                                            widget.width! * 0.9,
                                                        padding: EdgeInsets.only(
                                                            left:
                                                                widget.width! *
                                                                    0.06),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    "Clock Out Time :",
                                                                style: GoogleFonts.ptSans(
                                                                    fontSize: widget.width! <
                                                                            700
                                                                        ? widget.width! /
                                                                            35
                                                                        : widget.width! /
                                                                            42,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: GlobalColors
                                                                        .themeColor2,
                                                                    letterSpacing:
                                                                        0),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "$clockOut",
                                                                    style: GoogleFonts.ptSans(
                                                                        fontSize: widget.width! < 700
                                                                            ? widget.width! /
                                                                                35
                                                                            : widget.width! /
                                                                                42,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: GlobalColors
                                                                            .black,
                                                                        letterSpacing:
                                                                            0),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Text(
                                                              "Address :",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: GoogleFonts.ptSans(
                                                                  fontSize: widget.width! <
                                                                          700
                                                                      ? widget.width! /
                                                                          35
                                                                      : widget.width! /
                                                                          42,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: GlobalColors
                                                                      .themeColor2,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                            Text(
                                                              "${clockOutAddress}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: GoogleFonts.ptSans(
                                                                  fontSize: widget
                                                                              .width! <
                                                                          700
                                                                      ? widget.width! /
                                                                          32
                                                                      : widget.width! /
                                                                          42,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                              ],
                                            ),
                                    ],
                                  )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, s) =>
            Text("Not authenticated to perform this request   $err"),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

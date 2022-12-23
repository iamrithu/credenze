import 'dart:io';

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  late String? clockIn = null;
  late String? clockOut = null;
  bool installationComplete = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late File? newImage = null;

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
          });
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
  }

  installationClockIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    MapsAndLocation().locationPermisson().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
    });
    MapsAndLocation().getCamera().then((value) {
      setState(() {
        newImage = value;
      });
      Api().ClockIn(token!, ref.watch(userId), lat.toString(), long.toString(),
          newImage!);
      getInstallationAttendence();
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
                        child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: GlobalColors.themeColor2),
                                borderRadius: BorderRadius.circular(10)),
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
                                                  style:
                                                      GoogleFonts.akayaKanadaka(
                                                          fontSize: widget
                                                                      .width! <
                                                                  700
                                                              ? widget.width! /
                                                                  24
                                                              : widget.width! /
                                                                  42,
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
                                              elevation: 10,
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
                      Container(
                        width: widget.width,
                        height: widget.height! * 0.16,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: GlobalColors.themeColor2),
                              borderRadius: BorderRadius.circular(10)),
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
                                                  installationClockIn();
                                                },
                                      child: Text(
                                        "Clock In ",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.akayaKanadaka(
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
                                        elevation: 10,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              clockIn == null
                                                  ? "--/--/--"
                                                  : "$clockIn",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.akayaKanadaka(
                                                  fontSize: widget.width! < 700
                                                      ? widget.width! / 28
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
                              Flexible(
                                  child: Container(
                                child: Card(
                                  elevation: 10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Working Time",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.akayaKanadaka(
                                            fontSize: widget.width! < 700
                                                ? widget.width! / 28
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
                                                  style:
                                                      GoogleFonts.akayaKanadaka(
                                                          fontSize: widget
                                                                      .width! <
                                                                  700
                                                              ? widget.width! /
                                                                  25
                                                              : widget.width! /
                                                                  24,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GlobalColors
                                                              .themeColor2,
                                                          letterSpacing: 2),
                                                  children: [
                                                    TextSpan(
                                                      text: " " +
                                                          displayTimeWithSec
                                                              .toString(),
                                                      style: GoogleFonts.akayaKanadaka(
                                                          fontSize: widget
                                                                      .width! <
                                                                  700
                                                              ? widget.width! /
                                                                  20
                                                              : widget.width! /
                                                                  18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: GlobalColors
                                                              .themeColor,
                                                          letterSpacing: 2),
                                                    ),
                                                  ]),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
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
                                                  ref
                                                      .read(InstallationClockIn
                                                          .notifier)
                                                      .update((state) =>
                                                          !instalationClockIn);
                                                },
                                      child: Text(
                                        "Clock Out",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.akayaKanadaka(
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
                                        elevation: 10,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              clockOut == null
                                                  ? "--/--/--"
                                                  : "$clockOut",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.akayaKanadaka(
                                                  fontSize: widget.width! < 700
                                                      ? widget.width! / 28
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
                      Text("$lat"),
                      Text("$long"),
                      newImage == null
                          ? Text("null")
                          : Image.file(
                              newImage!,
                              width: widget.width! * 0.3,
                            )
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
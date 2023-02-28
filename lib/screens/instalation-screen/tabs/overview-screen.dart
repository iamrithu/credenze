import 'dart:convert';
import 'dart:io';

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  int? totalAmount = 0;
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
  late String imageUrl = "";

  bool installationComplete = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  late File? newImage = null;

  getclockInAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    print(placemarks.toString());
    setState(() {
      clockInAddress =
          "${placemarks[0].street},${placemarks[0].subLocality},${placemarks[0].locality},${placemarks[0].postalCode},${placemarks[0].administrativeArea},${placemarks[0].country}";
    });
  }

  getclockOutAddress(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    setState(() {
      clockOutAddress =
          "${placemarks[0].street},${placemarks[0].subLocality},${placemarks[0].locality},${placemarks[0].postalCode},${placemarks[0].administrativeArea},${placemarks[0].country}";
    });
  }

  getInstallationAttendence() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');

    final id = ref.watch(overViewId);

    ref.refresh(InstallationClockIn);
    Api().InstallationAttendence(token!, id).then((value) {
      List data = value.data["data"];

      if (data.isEmpty) {
        setState(() {
          clockIn = null;
          clockOut = null;
        });
      } else {
        print("rithi");
        ref.read(InstallationClockIn.notifier).update((state) => true);

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
            imageUrl = newdata["photo_url"];
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
    final prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    await Geolocator.isLocationServiceEnabled().then((value) {
      if (!value) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Location Access :",
              textAlign: TextAlign.start,
              style: GoogleFonts.ptSans(
                  fontSize: widget.width! < 700
                      ? widget.width! / 25
                      : widget.width! / 42,
                  fontWeight: FontWeight.w600,
                  color: GlobalColors.black,
                  letterSpacing: 0),
            ),
            content: Text(
              "We need your current location for attendance, So enable your location accsess.",
              textAlign: TextAlign.start,
              style: GoogleFonts.ptSans(
                  fontSize: widget.width! < 700
                      ? widget.width! / 30
                      : widget.width! / 42,
                  fontWeight: FontWeight.w500,
                  color: GlobalColors.themeColor2,
                  letterSpacing: 0),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Geolocator.openLocationSettings();
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      "Enable",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.ptSans(
                          fontSize: widget.width! < 700
                              ? widget.width! / 35
                              : widget.width! / 42,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          letterSpacing: 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        if (ref.watch(Installavailable) == true) {
          setState(() {
            loading = true;
            detailVisible = true;
          });

          MapsAndLocation().getCamera().then((value) {
            if (value == null) {
              setState(() {
                loading = false;
                detailVisible = false;
              });
            } else {
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
                    ref
                        .read(Installavailable.notifier)
                        .update((state) => false);
                    getInstallationAttendence();
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: "${data["message"]}",
                      autoCloseDuration: null,
                    );

                    setState(() {
                      loading = false;
                      detailVisible = false;
                    });
                  }
                });
              });
            }
          });
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Please Complete Previous Installation",
            autoCloseDuration: null,
          );
        }
      }
    });
  }

  installationClockOut(int? id) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('token');
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      widget: Text(
        "Do you have any additional expenses for this installation? If yes add in the expenses field before clock out.",
        textAlign: TextAlign.start,
        style: GoogleFonts.ptSans(
            fontSize:
                widget.width! < 700 ? widget.width! / 35 : widget.width! / 45,
            fontWeight: FontWeight.w600,
            color: GlobalColors.themeColor2,
            letterSpacing: 0),
      ),
      showCancelBtn: true,
      onCancelBtnTap: () {
        Navigator.pop(context);
        return null;
      },
      cancelBtnText: "Cancel",
      confirmBtnText: "Continue",
      onConfirmBtnTap: () {
        ref.read(pageIndex.notifier).update((state) => 2);
        ref.read(pageIndex.notifier).update((state) => 4);
        ref.read(initialIndex.notifier).update((state) => 4);
        setState(() {
          loading = true;
          detailVisible = true;
        });

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
              ref.read(Installavailable.notifier).update((state) => true);

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

        Navigator.pop(context);
      },
      autoCloseDuration: null,
    );
  }

  @override
  void initState() {
    getInstallationAttendence();

    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final installation = ref.watch(InsttalationOverVIewProvider);
    int? id = ref.watch(overViewId);
    return installation.when(
        data: (_data) {
          print(_data);
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: GlobalColors.themeColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                getInstallationAttendence();
                return ref.refresh(InsttalationOverVIewProvider);
              });
            },
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      if (DateFormat("dd-MM-yyyy").format(DateTime.now()) ==
                          ref.watch(selectedDate))
                        Container(
                          width: widget.width,
                          height: installationComplete
                              ? widget.height! * 0.3
                              : ref.watch(InstallationClockIn) == true
                                  ? widget.height! * 0.15
                                  : widget.height! * 0.3,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      margin: EdgeInsets.only(
                                          left: widget.width! * 0.03),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "${_data.installationName}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.ptSans(
                                              fontSize: widget.width! < 700
                                                  ? widget.width! / 40
                                                  : widget.width! / 42,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "${ref.watch(selectedDate)}",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.ptSans(
                                            fontSize: widget.width! < 700
                                                ? widget.width! / 40
                                                : widget.width! / 42,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.black,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: widget.width! * 0.85,
                                  child: ElevatedButton(
                                    onPressed: installationComplete
                                        ? null
                                        : ref.watch(InstallationClockIn) == true
                                            ? () {
                                                installationClockIn(id);
                                              }
                                            : () {
                                                installationClockOut(id);
                                              },
                                    child: Text(
                                      installationComplete
                                          ? "Installation Completed"
                                          : ref.watch(InstallationClockIn) ==
                                                  true
                                              ? "Clock In"
                                              : "Clock Out",
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
                                ),
                                Visibility(
                                  visible: installationComplete
                                      ? true
                                      : ref.watch(InstallationClockIn) == true
                                          ? false
                                          : true,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: widget.width! * 0.3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: widget.width! * 0.25,
                                              height: widget.height! * 0.1,
                                              child: Card(
                                                elevation: 10,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Clock In",
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
                                                              FontWeight.w600,
                                                          color: GlobalColors
                                                              .themeColor,
                                                          letterSpacing: 0),
                                                    ),
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          clockIn == null
                                                              ? "--/--/--"
                                                              : "$clockIn",
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
                                                                  FontWeight
                                                                      .w400,
                                                              color: GlobalColors
                                                                  .themeColor2,
                                                              letterSpacing: 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: widget.height! * 0.1,
                                        child: Card(
                                          elevation: 10,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
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
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 35
                                                          : widget.width! / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: GlobalColors
                                                          .themeColor,
                                                      letterSpacing: 0),
                                                ),
                                                StreamBuilder(
                                                  stream:
                                                      _stopWatchTimer.rawTime,
                                                  initialData: _stopWatchTimer
                                                      .rawTime.value,
                                                  builder:
                                                      ((context, snapshot) {
                                                    final value = snapshot.data;
                                                    final displayTimeWithoutSec =
                                                        StopWatchTimer
                                                            .getDisplayTime(
                                                                value!,
                                                                hours: true,
                                                                minute: true,
                                                                second: false,
                                                                milliSecond:
                                                                    false);
                                                    final displayTimeWithSec =
                                                        StopWatchTimer
                                                            .getDisplayTime(
                                                                value,
                                                                hours: false,
                                                                minute: false,
                                                                second: true,
                                                                milliSecond:
                                                                    false);
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
                                                                    ? widget.width! /
                                                                        33
                                                                    : widget.width! /
                                                                        24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: GlobalColors
                                                                    .themeColor2,
                                                                letterSpacing:
                                                                    0),
                                                            children: [
                                                              TextSpan(
                                                                text: " " +
                                                                    displayTimeWithSec
                                                                        .toString(),
                                                                style: GoogleFonts.ptSans(
                                                                    fontSize: widget.width! <
                                                                            700
                                                                        ? widget.width! /
                                                                            33
                                                                        : widget.width! /
                                                                            18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: GlobalColors
                                                                        .themeColor,
                                                                    letterSpacing:
                                                                        0),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: widget.width! * 0.25,
                                              height: widget.height! * 0.1,
                                              child: Card(
                                                elevation: 10,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Clock Out",
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
                                                              FontWeight.w600,
                                                          color: GlobalColors
                                                              .themeColor,
                                                          letterSpacing: 0),
                                                    ),
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          clockOut == null
                                                              ? "--/--/--"
                                                              : "$clockOut",
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
                                                                  FontWeight
                                                                      .w400,
                                                              color: GlobalColors
                                                                  .themeColor2,
                                                              letterSpacing: 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Container(
                        width: widget.width,
                        child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: widget.width! * 0.03),
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
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              elevation: 1,
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
                                          value:
                                              "${_data.branchinfo!.location}",
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
                                              elevation: 1,
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
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: widget.width! * 0.6,
                                            margin: EdgeInsets.only(
                                                left: widget.width! * 0.03),
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
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          widget.width! * 0.03),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.network(
                                                          imageUrl,
                                                          width: widget.width! *
                                                              0.25,
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
                                                                  ? widget
                                                                          .width! /
                                                                      38
                                                                  : widget
                                                                          .width! /
                                                                      42,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: GlobalColors
                                                                  .themeColor,
                                                              letterSpacing: 0),
                                                          children: [
                                                            TextSpan(
                                                              text: "$clockIn",
                                                              style: GoogleFonts.ptSans(
                                                                  fontSize: widget
                                                                              .width! <
                                                                          700
                                                                      ? widget.width! /
                                                                          38
                                                                      : widget.width! /
                                                                          42,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
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
                                                                    38
                                                                : widget.width! /
                                                                    42,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: GlobalColors
                                                                .themeColor,
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
                                                                    38
                                                                : widget.width! /
                                                                    42,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                    ? Container(
                                                        width:
                                                            widget.width! * 0.9,
                                                        height: widget.height! *
                                                            0.1,
                                                        child: Center(
                                                          child: Text(
                                                            "Clock Out Detail Not Available ...",
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
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        width:
                                                            widget.width! * 0.9,
                                                        padding: EdgeInsets.only(
                                                            left:
                                                                widget.width! *
                                                                    0.03),
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
                                                                            38
                                                                        : widget.width! /
                                                                            42,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: GlobalColors
                                                                        .themeColor,
                                                                    letterSpacing:
                                                                        0),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "$clockOut",
                                                                    style: GoogleFonts.ptSans(
                                                                        fontSize: widget.width! < 700
                                                                            ? widget.width! /
                                                                                38
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
                                                                          38
                                                                      : widget.width! /
                                                                          42,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: GlobalColors
                                                                      .themeColor,
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
                      Visibility(
                          visible: installationComplete,
                          child: Consumer(
                            builder: ((context, ref, child) {
                              final cat = ref.watch(expenseProvider);
                              return cat.when(
                                  data: ((_data) {
                                    return Container(
                                      width: widget.width,
                                      child: Card(
                                        elevation: 5,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  elevation: 1,
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          widget.width! * 0.03,
                                                      bottom: 10),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      "My Expenses",
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
                                                              .themeColor,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "S.NO",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 35
                                                          : widget.width! / 42,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      letterSpacing: 0),
                                                ),
                                                Text(
                                                  "Category",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 35
                                                          : widget.width! / 42,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      letterSpacing: 0),
                                                ),
                                                Text(
                                                  "Amount",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 35
                                                          : widget.width! / 42,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      letterSpacing: 0),
                                                ),
                                              ],
                                            ),
                                            for (var i = 0;
                                                i < _data.length;
                                                i++)
                                              Container(
                                                width: widget.width,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${i + 1}",
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
                                                              .black,
                                                          letterSpacing: 0),
                                                    ),
                                                    Text(
                                                      _data[i].categoryId == 1
                                                          ? "Petrol"
                                                          : "Food",
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
                                                              .black,
                                                          letterSpacing: 0),
                                                    ),
                                                    Text(
                                                      "${_data[i].amount} Rs",
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
                                                              .black,
                                                          letterSpacing: 0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            Divider(),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           vertical: 8.0),
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment
                                            //             .spaceEvenly,
                                            //     children: [
                                            //       Text(
                                            //         "Total",
                                            //         textAlign: TextAlign.start,
                                            //         style: GoogleFonts.ptSans(
                                            //             fontSize: widget
                                            //                         .width! <
                                            //                     700
                                            //                 ? widget.width! / 35
                                            //                 : widget.width! /
                                            //                     42,
                                            //             fontWeight:
                                            //                 FontWeight.w400,
                                            //             color: GlobalColors
                                            //                 .themeColor,
                                            //             letterSpacing: 0),
                                            //       ),
                                            //       Text(
                                            //         "${totalAmount}",
                                            //         textAlign: TextAlign.start,
                                            //         style: GoogleFonts.ptSans(
                                            //             fontSize: widget
                                            //                         .width! <
                                            //                     700
                                            //                 ? widget.width! / 35
                                            //                 : widget.width! /
                                            //                     42,
                                            //             fontWeight:
                                            //                 FontWeight.w400,
                                            //             color: GlobalColors
                                            //                 .themeColor,
                                            //             letterSpacing: 0),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  error: ((error, stackTrace) => Center(
                                      child: Text("No Datas Available"))),
                                  loading: (() => Text("")));
                            }),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        error: (err, s) => Center(child: Text("No Datas Available")),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

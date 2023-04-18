import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../apis/api.dart';
import '../../maps&location/map-location.dart';

class ServiceListScreen extends ConsumerStatefulWidget {
  const ServiceListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends ConsumerState<ServiceListScreen> {
  String text = "UserCurrent Location";
  List<AvailableMap> maps = [];
  dynamic isIncharge = 0;

  DateTime _selectedDate = DateTime.now();

  double lat = 0;
  double long = 0;

  void liveLocation() async {
    LocationSettings locationSetting =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSetting)
        .listen((event) {
      setState(() {
        lat = event.latitude;
        long = event.longitude;
        text = "lat : $lat long:$long";
      });
    });
  }

  onSelectedDates(context, value) {
    setState(() {
      _selectedDate = value;
    });

    Navigator.pop(context);
    ref
        .read(selectedDate.notifier)
        .update((state) => DateFormat("dd-MM-yyyy").format(_selectedDate));
  }

  todaydate() {
    setState(() {
      _selectedDate = DateTime.now();
    });
    ref
        .read(selectedDate.notifier)
        .update((state) => DateFormat("dd-MM-yyyy").format(_selectedDate));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer(
      builder: ((context, ref, child) {
        final data = ref.watch(userServiceListProvider);

        return data.when(
            data: (_data) {
              return RefreshIndicator(
                color: Colors.white,
                backgroundColor: GlobalColors.themeColor,
                strokeWidth: 4.0,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  return Future<void>.delayed(const Duration(seconds: 2), () {
                    ref.read(selectedDate.notifier).update((state) =>
                        DateFormat("dd-MM-yyyy").format(DateTime.now()));
                    return ref.refresh(userServiceListProvider);
                  });
                },
                child: Container(
                  width: width,
                  child: _data.isEmpty
                      ? ListView(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.012),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: width * 0.75,
                                      height: height * 0.05,
                                      alignment: Alignment.bottomLeft,
                                      margin: EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                            text: ref
                                                .watch(selectedDate)
                                                .toString(),
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 38
                                                    : width / 40,
                                                fontWeight: FontWeight.w800,
                                                color: GlobalColors.themeColor,
                                                letterSpacing: 2),
                                            children: []),
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      todaydate();
                                    },
                                    child: Container(
                                        width: width * 0.1,
                                        height: height * 0.05,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: _selectedDate.day ==
                                                    DateTime.now().day
                                                ? GlobalColors.themeColor
                                                : GlobalColors.white,
                                            border: Border.all(
                                                color: GlobalColors.themeColor),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Text(
                                            "Today",
                                            style: GoogleFonts.ptSans(
                                                color: _selectedDate.day ==
                                                        DateTime.now().day
                                                    ? GlobalColors.white
                                                    : GlobalColors.themeColor,
                                                fontSize: width < 700
                                                    ? width / 38
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: width,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: GlobalColors
                                                            .themeColor,
                                                        width: 3))),
                                            child: SfDateRangePicker(
                                              view: DateRangePickerView.month,
                                              toggleDaySelection: true,
                                              navigationDirection:
                                                  DateRangePickerNavigationDirection
                                                      .vertical,
                                              selectionShape:
                                                  DateRangePickerSelectionShape
                                                      .rectangle,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              monthViewSettings:
                                                  DateRangePickerMonthViewSettings(
                                                      firstDayOfWeek: 7),
                                              // onSelectionChanged: onSelectedDates,
                                              showActionButtons: true,
                                              onSubmit: (value) =>
                                                  onSelectedDates(
                                                      context, value),
                                              onCancel: () =>
                                                  Navigator.pop(context),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                        width: width * 0.1,
                                        height: height * 0.05,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: GlobalColors.themeColor),
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Center(
                                          child: Icon(FontAwesomeIcons.calendar,
                                              color: GlobalColors.themeColor),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width,
                              height: height * 0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "No Information Available",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 38
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView(children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.012),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: width * 0.75,
                                    height: height * 0.05,
                                    alignment: Alignment.bottomLeft,
                                    margin: EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                          text: ref
                                              .watch(selectedDate)
                                              .toString(),
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 38
                                                  : width / 40,
                                              fontWeight: FontWeight.w800,
                                              color: GlobalColors.themeColor,
                                              letterSpacing: 2),
                                          children: []),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    todaydate();
                                  },
                                  child: Container(
                                      width: width * 0.1,
                                      height: height * 0.05,
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: _selectedDate.day ==
                                                  DateTime.now().day
                                              ? GlobalColors.themeColor
                                              : GlobalColors.white,
                                          border: Border.all(
                                              color: GlobalColors.themeColor),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Text(
                                          "Today",
                                          style: GoogleFonts.ptSans(
                                              color: _selectedDate.day ==
                                                      DateTime.now().day
                                                  ? GlobalColors.white
                                                  : GlobalColors.themeColor,
                                              fontSize: width < 700
                                                  ? width / 38
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: width,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: GlobalColors
                                                          .themeColor,
                                                      width: 3))),
                                          child: SfDateRangePicker(
                                            view: DateRangePickerView.month,
                                            toggleDaySelection: true,
                                            navigationDirection:
                                                DateRangePickerNavigationDirection
                                                    .vertical,
                                            selectionShape:
                                                DateRangePickerSelectionShape
                                                    .rectangle,
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .single,
                                            monthViewSettings:
                                                DateRangePickerMonthViewSettings(
                                                    firstDayOfWeek: 7),
                                            // onSelectionChanged: onSelectedDates,
                                            showActionButtons: true,
                                            onSubmit: (value) =>
                                                onSelectedDates(context, value),
                                            onCancel: () =>
                                                Navigator.pop(context),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                      width: width * 0.1,
                                      height: height * 0.05,
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: GlobalColors.themeColor2),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Icon(Icons.date_range,
                                            color: GlobalColors.themeColor2),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          for (var i = 0; i < _data.length; i++)
                            Stack(
                              children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: GlobalColors.themeColor,
                                  child: Container(
                                    width: width,
                                    height: height * 0.2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        ref
                                            .read(ServiceId.notifier)
                                            .update((state) => _data[i].id!);
                                        Api()
                                            .getServiceIncaherge(
                                                ref.read(newToken)!,
                                                ref.read(ServiceId),
                                                "${DateFormat("dd-MM-yyyy").format(DateTime.now())}")
                                            .then((value) {
                                          ref
                                              .read(initialIndex.notifier)
                                              .update((state) => 0);
                                          ref
                                              .read(pageIndex.notifier)
                                              .update((state) => 7);
                                          ref
                                              .read(serviceinChargeId.notifier)
                                              .update(
                                                  (state) => value.toString());
                                        });

                                        // if (_data[i].site ==
                                        //     null) {
                                        //   ref
                                        //       .read(inChargeId.notifier)
                                        //       .update((state) => 0);
                                        // } else {
                                        //   ref.read(inChargeId.notifier).update(
                                        //       (state) => _data[i]
                                        //           .siteInchargeToday!
                                        //           .user!
                                        //           .id!);
                                        // }
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.all(width * 0.03),
                                          width: width * 0.965,
                                          height: height * 0.2,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.25,
                                                          child: Text(
                                                            "Service Code",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          child: Text(
                                                            "${_data[i].servicePrefix}${_data[i].serviceCode ?? "--"}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.25,
                                                          child: Text(
                                                            "Customer Name",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          child: Text(
                                                            "${_data[i].customerName ?? "--"}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.25,
                                                          child: Text(
                                                            "Service Site",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          child: Text(
                                                            "${_data[i].customerAddress ?? "--"}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.25,
                                                          child: Text(
                                                            "Branch ",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          child: Text(
                                                            "${_data[i].branch!.location ?? "--"}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: width * 0.25,
                                                          child: Text(
                                                            "Service Status",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width * 0.45,
                                                          child: Text(
                                                            "${_data[i].status!.statusName ?? "--"}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 38
                                                                    : width /
                                                                        45,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                letterSpacing:
                                                                    0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (_data[i].siteLatitude !=
                                                      null &&
                                                  _data[i].siteLongitude !=
                                                      null)
                                                InkWell(
                                                  onTap: () {
                                                    // if (_data[i].siteLatitude ==
                                                    //         null ||
                                                    //     _data[i].siteLongitude ==
                                                    //         null) {
                                                    //   QuickAlert.show(
                                                    //     context: context,
                                                    //     type:
                                                    //         QuickAlertType.error,
                                                    //     widget: Text(
                                                    //       "This installation did not has location details",
                                                    //       textAlign:
                                                    //           TextAlign.start,
                                                    //       style: GoogleFonts.ptSans(
                                                    //           fontSize: width <
                                                    //                   700
                                                    //               ? width / 38
                                                    //               : width / 45,
                                                    //           fontWeight:
                                                    //               FontWeight.w600,
                                                    //           color: GlobalColors
                                                    //               .themeColor2,
                                                    //           letterSpacing: 0),
                                                    //     ),
                                                    //     showCancelBtn: false,
                                                    //     autoCloseDuration:
                                                    //         Duration(
                                                    //             milliseconds:
                                                    //                 2000),
                                                    //   );
                                                    //   return null;
                                                    // }

                                                    MapsAndLocation()
                                                        .openMapsSheet(
                                                            context,
                                                            double.parse(_data[i]
                                                                .siteLatitude!),
                                                            double.parse(_data[
                                                                    i]
                                                                .siteLongitude!));
                                                  },
                                                  child: Container(
                                                    width: width * 0.2,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          width: width * 0.1,
                                                          child: Card(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    2),
                                                            elevation: 10,
                                                            child: Image(
                                                              image: AssetImage(
                                                                  "Assets/images/map.png"),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ]),
                ),
              );
            },
            error: (err, s) => Center(
                  child: Text(
                    "No Information Available",
                    style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 38 : width / 45,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0),
                  ),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
      }),
    );
  }
}

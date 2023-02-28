import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../maps&location/map-location.dart';

class InstalationScreen extends ConsumerStatefulWidget {
  const InstalationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<InstalationScreen> createState() => _InstalationScreenState();
}

class _InstalationScreenState extends ConsumerState<InstalationScreen> {
  String text = "UserCurrent Location";
  List<AvailableMap> maps = [];
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
        final data = ref.watch(userInstallationListProvider);

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
                    return ref.refresh(userInstallationProvider);
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
                                                    ? width / 35
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
                                                    ? width / 35
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
                                              ? width / 35
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
                                                  ? width / 35
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
                                                  ? width / 35
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
                                            .read(initialIndex.notifier)
                                            .update((state) => 0);
                                        ref
                                            .read(pageIndex.notifier)
                                            .update((state) => 4);

                                        if (_data[i].siteInchargeToday ==
                                            null) {
                                          ref
                                              .read(inChargeId.notifier)
                                              .update((state) => 0);
                                        } else {
                                          ref.read(inChargeId.notifier).update(
                                              (state) => _data[i]
                                                  .siteInchargeToday!
                                                  .user!
                                                  .id!);
                                        }

                                        ref.read(overViewId.notifier).update(
                                            (state) =>
                                                _data[i].installationId!);
                                        return ref.refresh(membersProvider);
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
                                                            "Installation Code",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                            "${_data[i].installationPrefix}${_data[i].installationNos}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                            "Installation Name",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                            "${_data[i].installationName}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                                    ? width / 35
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
                                                            "${_data[i].customerName}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                                    ? width / 35
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
                                                            "${_data[i].branchinfo!.location!}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                            "Installation Status",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                                            "${_data[i].statusinfo!.statusName!}",
                                                            style: GoogleFonts.ptSans(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
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
                                              InkWell(
                                                onTap: () {
                                                  MapsAndLocation()
                                                      .openMapsSheet(
                                                          context,
                                                          double.parse(_data[i]
                                                              .siteLatitude!),
                                                          double.parse(_data[i]
                                                              .siteLongitude!));
                                                },
                                                child: Container(
                                                  width: width * 0.2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: width * 0.1,
                                                        child: Card(
                                                          margin:
                                                              EdgeInsets.all(2),
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
                        fontSize: width < 700 ? width / 35 : width / 45,
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

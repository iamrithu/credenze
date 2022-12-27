import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../maps&location/map-location.dart';

class InstalationScreen extends StatefulWidget {
  const InstalationScreen({Key? key}) : super(key: key);

  @override
  State<InstalationScreen> createState() => _InstalationScreenState();
}

class _InstalationScreenState extends State<InstalationScreen> {
  String text = "UserCurrent Location";
  List<AvailableMap> maps = [];

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer(
      builder: ((context, ref, child) {
        final data = ref.watch(userInstallationProvider);

        return data.when(
            data: (_data) {
              return RefreshIndicator(
                color: Colors.white,
                backgroundColor: GlobalColors.themeColor,
                strokeWidth: 4.0,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  return Future<void>.delayed(const Duration(seconds: 2), () {
                    return ref.refresh(userInstallationProvider);
                  });
                },
                child: Container(
                  width: width,
                  child: ListView(children: [
                    _data.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "No Information Available",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.black,
                                      fontSize:
                                          width < 700 ? width / 35 : width / 45,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0),
                                ),
                              ),
                            ],
                          )
                        : Text(""),
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
                              height: height * 0.18,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(pageIndex.notifier)
                                      .update((state) => 6);

                                  ref.read(overViewId.notifier).update(
                                      (state) => _data[i].installationId!);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(width * 0.03),
                                    width: width * 0.965,
                                    height: height * 0.18,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Installation Code",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      "${_data[i].installationPrefix}${_data[i].installationNos}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
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
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      "${_data[i].installationName}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
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
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      "${_data[i].customerName}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Branch Name",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      "${_data[i].branchId}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
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
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      "${_data[i].installationStatus}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
                                                          fontSize: width < 700
                                                              ? width / 35
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            MapsAndLocation().openMapsSheet(
                                                context,
                                                double.parse(
                                                    _data[i].siteLatitude!),
                                                double.parse(
                                                    _data[i].siteLongitude!));
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
                                                    margin: EdgeInsets.all(2),
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

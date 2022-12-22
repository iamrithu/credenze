import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';

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

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Service Are Disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Service Are Disabled");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permissions are Permanently Disabled");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  openMapsSheet(context, lat, long) async {
    Coords location = Coords(lat, long);
    try {
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showDirections(
                            destination: location,
                            destinationTitle: "Destination",
                          );
                          Navigator.pop(context);
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
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
              return Container(
                width: width,
                child: ListView(children: [
                  _data.isEmpty
                      ? Center(
                          child: Text(
                            "No Information Available",
                            style: GoogleFonts.akayaKanadaka(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        )
                      : Text(""),
                  for (var i = 0; i < _data.length; i++)
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                                    .update((state) => 5);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(width * 0.03),
                                  width: width * 0.96,
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
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
                                                                : width / 45,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.45,
                                                  child: Text(
                                                    " : ${_data[i].installationPrefix}${_data[i].installationNos}",
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
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
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
                                                                : width / 45,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.45,
                                                  child: Text(
                                                    " : ${_data[i].branchId}",
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
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
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
                                                                : width / 45,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.45,
                                                  child: Text(
                                                    " : ${_data[i].customerName}",
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
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
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
                                                                : width / 45,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.45,
                                                  child: Text(
                                                    " : ${_data[i].installationName}",
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
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
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
                                                                : width / 45,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0),
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.45,
                                                  child: Text(
                                                    " : ${_data[i].installationStatus}",
                                                    style: GoogleFonts
                                                        .akayaKanadaka(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 30
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
                                          openMapsSheet(
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
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * 0.5)),
                                                  padding: EdgeInsets.all(
                                                      width * 0.03),
                                                  child: Icon(
                                                    Icons.navigation,
                                                    color: GlobalColors.white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ]),
              );
            },
            error: (err, s) => Text("No Information Available"),
            loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
      }),
    );
  }
}

import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-location/installation_location_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../models/installation-list-model.dart';

class InstalationScreen extends ConsumerWidget {
  const InstalationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  for (var i = 0; i < _data.length; i++)
                    InkWell(
                      onTap: () {
                        ref.read(pageIndex.notifier).update((state) => 5);
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width,
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
                                            "Lead Id",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                            "#1",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.black,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
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
                                            "Lead Name",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                            "Mr Rithi Mahesh Kumar",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.black,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
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
                                            "Company Name",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                            "Themeparrot",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.black,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
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
                                            "Created   ",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                            "06-12-2022",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.black,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
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
                                            "Lead Value ",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                            "10000 Rs",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.black,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
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
                                            "Lead Agend   ",
                                            style: GoogleFonts.abel(
                                                color: GlobalColors.themeColor2,
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Mrs Prabavathi",
                                                style: GoogleFonts.abel(
                                                    color: GlobalColors.black,
                                                    fontSize: width < 700
                                                        ? width / 30
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                              ),
                                              Text(
                                                "Pending",
                                                style: GoogleFonts.abel(
                                                    color: Color.fromARGB(
                                                        255, 225, 198, 27),
                                                    fontSize: width < 700
                                                        ? width / 30
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ]),
              );
            },
            error: (err, s) => Text("No Information Available"),
            loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ));
      }),

      // child: LayoutBuilder(builder: ((context, constraints) {
      //   return DefaultTabController(
      //     initialIndex: 0,
      //     length: 2,
      //     child: Scaffold(
      //       appBar: AppBar(
      //         elevation: 0,
      //         backgroundColor: GlobalColors.white,
      //         automaticallyImplyLeading: false,
      //         bottom: PreferredSize(
      //           preferredSize: Size(width, height * 0.04),
      //           child: Card(
      //             child: TabBar(
      //               labelColor: GlobalColors.themeColor,
      //               unselectedLabelColor: GlobalColors.themeColor2,
      //               indicatorSize: TabBarIndicatorSize.label,
      //               dragStartBehavior: DragStartBehavior.start,
      //               overlayColor: MaterialStateProperty.resolveWith((states) {
      //                 if (states.contains(MaterialState.pressed)) {
      //                   return GlobalColors.themeColor2;
      //                 }
      //                 return GlobalColors.themeColor;
      //               }),
      //               splashBorderRadius: BorderRadius.circular(20),
      //               tabs: <Widget>[
      //                 Tab(
      //                   child: Text(
      //                     "Instalation",
      //                     style: GoogleFonts.abel(
      //                         fontSize: width < 700 ? width / 28 : width / 45,
      //                         fontWeight: FontWeight.w400,
      //                         letterSpacing: 0),
      //                   ),
      //                   icon: Icon(
      //                     Icons.install_desktop_sharp,
      //                     size: width < 700 ? width / 28 : width / 45,
      //                   ),
      //                 ),
      //                 Tab(
      //                   child: Text(
      //                     "Task Overview",
      //                     style: GoogleFonts.abel(
      //                         fontSize: width < 700 ? width / 28 : width / 45,
      //                         fontWeight: FontWeight.w400,
      //                         letterSpacing: 0),
      //                   ),
      //                   icon: Icon(
      //                     Icons.task_rounded,
      //                     size: width < 700 ? width / 28 : width / 45,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //       body: TabBarView(
      //         children: <Widget>[
      //           Center(
      //             child: Text("Coiming soon"),
      //           ),
      //           Center(
      //             child: Text("Coiming soon"),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // })),
    );
  }
}

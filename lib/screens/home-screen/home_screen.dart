import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_appbar.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/attenence-screen/attenence_screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/taskDetailsSCreen.dart';
import 'package:credenze/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../dashboard-screen/dashboard_screen.dart';
import '../instalation-screen/instalation_screen.dart';
import '../instalation-screen/installation_detail_screen.dart';
import '../lead-screen/leads_screen.dart';
import '../lead-screen/tabs/lead-details-screen.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  static const String routeName = "/actual-home";
  HomeScreen({Key? key}) : super(key: key);

  List<IconData> navigationIcon = [
    FontAwesomeIcons.clock,
    Icons.settings,
    FontAwesomeIcons.calendarDays,
    // FontAwesomeIcons.chartBar,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final int _page = ref.watch(pageIndex);

    final bool isNetworkConnected = ref.watch(netWorkConnectivity);

    demo() async {
      bool result = await InternetConnectionChecker().hasConnection;
      ref.read(netWorkConnectivity.notifier).update((state) => result);
    }

    demo();
    List<String> name = [
      "Dashboard",
      "My Installations",
      "Attendence",
      // "Leads",
      "Profile"
    ];
    List<Widget> pages = [
      DashboardScreen(),
      InstalationScreen(),
      AttendenceScreen(),
      // LeadScreen(),
      ProfileScreen(),
      // LeadDetailsScreen(),
      InstallationDetailScreen(),
      TaskDetailsSCreen(),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.05),
        child: CustomAppBar(page: ref.watch(pageIndex)),
      ),
      body: SafeArea(
        child: isNetworkConnected
            ? Container(width: width, height: height, child: pages[_page])
            : Container(
                width: width,
                height: height * 1,
                child: Center(
                  child: Lottie.asset('Assets/json/no-internet.json',
                      width: width),
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Card(
          margin: EdgeInsets.only(
            bottom: height * 0.02,
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: GlobalColors.themeColor),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          child: Container(
            width: width,
            height: height * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < navigationIcon.length; i++)
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: _page == i
                                      ? GlobalColors.themeColor
                                      : GlobalColors.white,
                                  width: 2))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              ref.read(pageIndex.notifier).update((state) => i);
                              ref.read(selectedDate.notifier).update((state) =>
                                  DateFormat("dd-MM-yyyy")
                                      .format(DateTime.now()));
                            },
                            color: _page == i
                                ? GlobalColors.themeColor
                                : GlobalColors.themeColor2,
                            icon: Icon(
                              navigationIcon[i],
                              size: _page == i ? height * 0.025 : height * 0.02,
                            ),
                          ),
                          _page == i
                              ? Text(
                                  name[i],
                                  style: GoogleFonts.ptSans(
                                      fontSize:
                                          width < 700 ? width / 38 : width / 45,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: GlobalColors.themeColor),
                                )
                              : Text(
                                  "",
                                  style: GoogleFonts.ptSans(
                                      fontSize: 0,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0,
                                      color: GlobalColors.themeColor),
                                ),
                        ],
                      ),
                    ),
                  if (ref.watch(pageIndex) > 4)
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  color: GlobalColors.themeColor, width: 2))),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            color: GlobalColors.themeColor,
                            icon: Icon(
                              Icons.menu,
                              size: height * 0.025,
                            ),
                          ),
                          Text(
                            "More",
                            style: GoogleFonts.ptSans(
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: GlobalColors.themeColor),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

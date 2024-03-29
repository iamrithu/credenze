import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_appbar.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/attenence-screen/attenence_screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/task-screen.dart';
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
import '../overall-expense/overAllExpenseScreen.dart';
import '../services-screen/service-list-details.dart';
import '../services-screen/service-tabs/task/task-detail-screen.dart';
import '../services-screen/services-list.dart';
import '../task/taskDetailScreen.dart';
import '../task/taskScreen.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  static const String routeName = "/actual-home";
  HomeScreen({Key? key}) : super(key: key);

  List<IconData> navigationIcon = [
    Icons.house,
    Icons.trolley,
    Icons.settings,
    Icons.task,
    Icons.margin,
    // Icons.person,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final int _page = ref.watch(pageIndex);
    final user = ref.watch(userDataProvider);

    final bool isNetworkConnected = ref.watch(netWorkConnectivity);

    demo() async {
      bool result = await InternetConnectionChecker().hasConnection;
      ref.read(netWorkConnectivity.notifier).update((state) => result);
    }

    demo();
    List<String> name = [
      "Dashboard",
      "Installations",
      "Service",
      "Task",
      "Attendance",
    ];
    List<Widget> pages = [
      DashboardScreen(),
      InstalationScreen(),
      ServiceListScreen(),
      MainTaskScreen(),
      AttendenceScreen(),
      // LeadScreen(),
      // LeadDetailsScreen(),
      InstallationDetailScreen(),
      TaskDetailsSCreen(),
      ServiceDetailScreen(),
      ServiceTaskDetailsSCreen(),
      ProfileScreen(),
      TaskDetailScreen(),
      OverAllExpense()
    ];
    return Scaffold(
      appBar: _page < 1
          ? PreferredSize(
              preferredSize: Size(width, height * 0.05),
              child: AppBar(
                centerTitle: true,
                title: Text(
                  "Dashboard",
                  style: GoogleFonts.ptSans(
                      fontSize: width < 700 ? width / 20 : width / 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0),
                ),
                actions: [
                  user.when(
                      data: (_data) {
                        return InkWell(
                          onTap: () {
                            ref.read(pageIndex.notifier).update((state) => 9);
                          },
                          child: Container(
                            margin: EdgeInsets.all(3),
                            width: 50,
                            child: CircleAvatar(
                              radius: 56,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(2), // Border radius
                                child: ClipOval(
                                  child: Image.network(
                                    _data.imageUrl.toString(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      error: (e, s) => Center(
                            child: Text("${e}"),
                          ),
                      loading: () => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ))
                ],
              ),
            )
          : PreferredSize(
              preferredSize: Size(width, height * 0.05),
              child: CustomAppBar(page: ref.watch(pageIndex)),
            ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Color.fromARGB(203, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 252, 202, 201),
                        Color.fromARGB(255, 247, 247, 247)
                      ],
                      stops: [0, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                width: width,
                height: height * 0.14,
                child: user.when(
                  data: (_data) {
                    return InkWell(
                      onTap: () {
                        ref.read(pageIndex.notifier).update((state) => 9);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(3),
                                width: 50,
                                child: CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        2), // Border radius
                                    child: ClipOval(
                                      child: Image.network(
                                        _data.imageUrl.toString(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(3),
                                    child: Text(
                                      "${_data.name}",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 45,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0,
                                          color: GlobalColors.themeColor2),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(3),
                                    child: _data.employeeDetail == null
                                        ? Text("")
                                        : Text(
                                            "${_data.employeeDetail!.designation!.name}",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 35
                                                    : width / 45,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0,
                                                color: GlobalColors.themeColor),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  error: (e, s) => Center(
                    child: Text("${e}"),
                  ),
                  loading: () => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                ref.read(pageIndex.notifier).update((state) => 11);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    width: width,
                    height: height * 0.05,
                    child: Center(
                      child: Text(
                        "Overall Expenses",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 35 : width / 45,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: GlobalColors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Divider(
              color: GlobalColors.themeColor2,
              thickness: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Container(
                width: width,
                height: height * 0.03,
                child: Center(
                  child: Text(
                    "Version 1.0.0",
                    style: GoogleFonts.ptSans(
                        fontSize: width < 700 ? width / 35 : width / 45,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        color: GlobalColors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      // body: Container(
      //   child: Center(
      //     child: Text("rithi"),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Card(
          margin: EdgeInsets.only(
            bottom: height * 0.02,
          ),
          elevation: 1,
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: GlobalColors.themeColor),
            borderRadius: BorderRadius.circular(width * 0.1),
          ),
          child: Container(
            width: width,
            height: height * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 247, 247),
                    Color.fromARGB(255, 252, 201, 199),
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < navigationIcon.length; i++)
                    Container(
                      decoration: BoxDecoration(),
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
                              ref.read(servicedDate.notifier).update((state) =>
                                  DateFormat("dd-MM-yyyy")
                                      .format(DateTime.now()));
                            },
                            color: _page == i
                                ? GlobalColors.themeColor
                                : GlobalColors.black,
                            icon: Icon(
                              navigationIcon[i],
                              size: _page == i ? height * 0.025 : height * 0.02,
                            ),
                          ),
                          Text(name[i],
                              style: GoogleFonts.ptSans(
                                fontSize: _page == i
                                    ? width < 700
                                        ? width / 38
                                        : width / 50
                                    : width < 700
                                        ? width / 44
                                        : width / 60,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                                color: _page == i
                                    ? GlobalColors.themeColor
                                    : GlobalColors.black,
                              ))
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
                          ),
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

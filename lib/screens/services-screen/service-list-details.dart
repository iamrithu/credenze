import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/file-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/members-screen.dart';

import 'package:credenze/screens/instalation-screen/tabs/overview-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/task-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/work_update.dart';
import 'package:credenze/screens/services-screen/service-tabs/expenses/expenses-screen.dart';
import 'package:credenze/screens/services-screen/service-tabs/file/file-screen.dart';
import 'package:credenze/screens/services-screen/service-tabs/members/member-screen.dart';
import 'package:credenze/screens/services-screen/service-tabs/overview/overview-screen.dart';
import 'package:credenze/screens/services-screen/service-tabs/task/task-screen.dart';
import 'package:credenze/screens/services-screen/service-tabs/work-update/work-update-screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../apis/api.dart';
import '../instalation-screen/tabs/expenses-screen.dart';

class ServiceDetailScreen extends ConsumerStatefulWidget {
  const ServiceDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends ConsumerState<ServiceDetailScreen> {
  bool isIncharge = false;
  getServiceIncahrge() {
    Api()
        .getServiceIncaherge(ref.read(newToken)!, ref.read(ServiceId),
            "${DateFormat("dd-MM-yyyy").format(DateTime.now())}")
        .then((value) {
      if (value.toString() == "0") {
        setState(() {
          isIncharge = false;
        });
      } else {
        isIncharge = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getServiceIncahrge();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<String> tabName = [
      "Overview",
      "Task",
      "Members",
      "Files",
      if (ref.watch(ServiceClockIn) == false)
        if (ref.watch(serviceinChargeId) == "1") "Workupdate",
      if (ref.watch(ServiceClockIn) == false) "Expenses",
    ];
    List<IconData> tabIcon = [
      Icons.view_comfy,
      Icons.task_sharp,
      Icons.person_add,
      Icons.file_upload_outlined,
      if (ref.watch(ServiceClockIn) == false)
        if (ref.watch(serviceinChargeId) == "1") Icons.work_history,
      if (ref.watch(ServiceClockIn) == false) FontAwesomeIcons.moneyBills,
    ];

    return Container(
      width: width,
      height: width < 700 ? height * 0.8 : height * 0.9,
      child: LayoutBuilder(builder: ((context, constraints) {
        return DefaultTabController(
          initialIndex: ref.watch(initialIndex),
          length: tabName.length,
          animationDuration: Duration(milliseconds: 600),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Color.fromARGB(15, 255, 255, 255),
              bottom: PreferredSize(
                preferredSize: Size(width, height * 0.04),
                child: Card(
                  // color: Color.fromARGB(255, 250, 242, 243),
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(4),
                  //     side: BorderSide(color: GlobalColors.themeColor)),
                  child: TabBar(
                    labelColor: GlobalColors.themeColor,
                    controller: null,
                    unselectedLabelColor: GlobalColors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    dragStartBehavior: DragStartBehavior.start,
                    isScrollable: tabName.length > 5 ? true : false,
                    onTap: (int) {
                      ref.read(initialIndex.notifier).update((state) => 0);
                    },
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return GlobalColors.themeColor2;
                      }
                      return GlobalColors.themeColor;
                    }),
                    splashBorderRadius: BorderRadius.circular(4),
                    tabs: <Widget>[
                      for (var i = 0; i < tabName.length; i++)
                        Tab(
                          child: Text(
                            "${tabName[i]}",
                            style: GoogleFonts.ptSans(
                                fontSize: tabName.length > 5
                                    ? width < 700
                                        ? width / 40
                                        : width / 45
                                    : width < 700
                                        ? width / 38
                                        : width / 45,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0),
                          ),
                          icon: Icon(
                            tabIcon[i],
                            size: width < 700 ? width / 35 : width / 45,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              child: TabBarView(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return ServiceOverviewScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return ServiceTaskScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return ServiceMemberScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: width < 400
                            ? height * 0.67
                            : width < 700
                                ? height * 0.69
                                : height * 0.7,
                        child: LayoutBuilder(builder: ((context, constraints) {
                          return ServiceFileScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  if (ref.watch(ServiceClockIn) == false)
                    if (ref.watch(serviceinChargeId) == "1")
                      Column(
                        children: [
                          Container(
                            width: width,
                            height: width < 400
                                ? height * 0.67
                                : width < 700
                                    ? height * 0.69
                                    : height * 0.7,
                            child:
                                LayoutBuilder(builder: ((context, constraints) {
                              return ServiceWorkUpdateScreen(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                              );
                            })),
                          )
                        ],
                      ),
                  if (ref.watch(ServiceClockIn) == false)
                    Column(
                      children: [
                        Container(
                          width: width,
                          height: width < 400
                              ? height * 0.67
                              : width < 700
                                  ? height * 0.69
                                  : height * 0.7,
                          child:
                              LayoutBuilder(builder: ((context, constraints) {
                            return SeviceExpenseScreen(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                            );
                          })),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}

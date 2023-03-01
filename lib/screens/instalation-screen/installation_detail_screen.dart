import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/file-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/members-screen.dart';

import 'package:credenze/screens/instalation-screen/tabs/overview-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/task-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/work_update.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'tabs/expenses-screen.dart';

class InstallationDetailScreen extends ConsumerStatefulWidget {
  const InstallationDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InstallationDetailScreenState createState() =>
      _InstallationDetailScreenState();
}

class _InstallationDetailScreenState
    extends ConsumerState<InstallationDetailScreen> {
  @override
  void initState() {
    super.initState();
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
      if (ref.watch(InstallationClockIn) == false)
        if (ref.watch(inChargeId) == ref.watch(userId)) "Workupdate",
      if (ref.watch(InstallationClockIn) == false) "Expenses",
    ];
    List<IconData> tabIcon = [
      Icons.view_comfy,
      Icons.task_sharp,
      Icons.person_add,
      Icons.file_upload_outlined,
      if (ref.watch(InstallationClockIn) == false)
        if (ref.watch(inChargeId) == ref.watch(userId)) Icons.work_history,
      if (ref.watch(InstallationClockIn) == false) FontAwesomeIcons.moneyBills,
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
                  child: TabBar(
                    labelColor: GlobalColors.themeColor,
                    unselectedLabelColor: GlobalColors.themeColor2,
                    indicatorSize: TabBarIndicatorSize.label,
                    dragStartBehavior: DragStartBehavior.start,
                    isScrollable: tabName.length > 5 ? true : false,
                    onTap: (int) {
                      ref.read(initialIndex.notifier).update((state) => int);
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
                                fontWeight: FontWeight.w400,
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
                          return OverviewScreen(
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
                          return TaskScreen(
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
                          return MemberScreen(
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
                          return FileScreen(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          );
                        })),
                      )
                    ],
                  ),
                  if (ref.watch(InstallationClockIn) == false)
                    if (ref.watch(inChargeId) == ref.watch(userId))
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
                              return WorkUpdateScreen(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                              );
                            })),
                          )
                        ],
                      ),
                  if (ref.watch(InstallationClockIn) == false)
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
                            return ExpenseScreen(
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

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../const/global_colors.dart';

class TaskDetailsSCreen extends ConsumerStatefulWidget {
  const TaskDetailsSCreen({Key? key}) : super(key: key);

  @override
  _TaskDetailsSCreenState createState() => _TaskDetailsSCreenState();
}

class _TaskDetailsSCreenState extends ConsumerState<TaskDetailsSCreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final taskDetail = ref.watch(installationTaskDetailsProvider);
    return taskDetail.when(
        data: (_data) {
          return Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Expanded(
                    child: Card(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "TaskDetails ",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.black,
                                  fontSize:
                                      width < 700 ? width / 24 : width / 45,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Category   ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(":"),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${_data.category!.name}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Start Date ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(":"),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _data.startDate == null
                                    ? "--"
                                    : "${DateFormat("dd-MM-yyyy").format(_data.startDate!)}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "End Date   ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(":"),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _data.endDate == null
                                    ? "--"
                                    : "${DateFormat("dd-MM-yyyy").format(_data.endDate!)}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Details      ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(":"),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${_data.taskDescription ?? "--"}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                        if (_data.isRemovable != 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  "Removable Quantity",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.black,
                                      fontSize:
                                          width < 700 ? width / 35 : width / 45,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${_data.removeableCount ?? "--"}",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.themeColor,
                                      fontSize:
                                          width < 700 ? width / 35 : width / 45,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                )),
                if (_data.isRemovable != 0)
                  Expanded(
                    flex: 2,
                    child: Text(""),
                  ),
                if (_data.isRemovable == 0)
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width,
                      child: Card(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "Products List ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 30 : width / 45,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 225, 223, 223),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 92, 90, 90),
                                              width: 0.5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text("Product Name"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 225, 223, 223),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 92, 90, 90),
                                              width: 0.5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text("Unit"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 225, 223, 223),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 92, 90, 90),
                                              width: 0.5),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text("Quantity"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              for (var i = 0; i < _data.items!.length; i++)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${_data.items![i].product!.name}",
                                                style: GoogleFonts.ptSans(
                                                    color: Color.fromARGB(
                                                        255, 104, 100, 100),
                                                    fontSize: width < 700
                                                        ? width / 40
                                                        : width / 45,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${_data.items![i].unit!.shortName}",
                                                style: GoogleFonts.ptSans(
                                                    color: Color.fromARGB(
                                                        255, 104, 100, 100),
                                                    fontSize: width < 700
                                                        ? width / 40
                                                        : width / 45,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "${_data.items![i].quantity}",
                                                style: GoogleFonts.ptSans(
                                                    color: Color.fromARGB(
                                                        255, 104, 100, 100),
                                                    fontSize: width < 700
                                                        ? width / 40
                                                        : width / 45,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      _data.items![i].serialnos!.isEmpty
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Text(""),
                                            )
                                          : Container(
                                              width: width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Serial No:",
                                                    style: GoogleFonts.ptSans(
                                                        color: GlobalColors
                                                            .themeColor,
                                                        fontSize: width < 700
                                                            ? width / 40
                                                            : width / 45,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 0),
                                                  ),
                                                  Wrap(
                                                    children: [
                                                      for (var j = 0;
                                                          j <
                                                              _data
                                                                  .items![i]
                                                                  .serialnos!
                                                                  .length;
                                                          j++)
                                                        Card(
                                                          elevation: 4,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "${_data.items![i].serialnos![j].serialno}",
                                                              style: GoogleFonts.ptSans(
                                                                  color: GlobalColors
                                                                      .black,
                                                                  fontSize: width <
                                                                          700
                                                                      ? width /
                                                                          40
                                                                      : width /
                                                                          45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        )
                                                      // Container(
                                                      //   alignment:
                                                      //       Alignment.center,
                                                      //   margin: EdgeInsets.all(4),
                                                      //   constraints:
                                                      //       BoxConstraints(),
                                                      //   decoration: BoxDecoration(
                                                      //     color: Color.fromARGB(
                                                      //         255, 252, 235, 235),
                                                      //     border: Border.all(
                                                      //         color:
                                                      //             Color.fromARGB(
                                                      //                 255,
                                                      //                 248,
                                                      //                 132,
                                                      //                 134),
                                                      //         width: 0.5),
                                                      //     borderRadius:
                                                      //         BorderRadius
                                                      //             .circular(5),
                                                      //   ),
                                                      //   padding:
                                                      //       EdgeInsets.symmetric(
                                                      //           vertical: 4,
                                                      //           horizontal: 8),
                                                      // child: Text(
                                                      //   "${_data.items![i].serialnos![j].serialno}",
                                                      //   style:
                                                      //       GoogleFonts.ptSans(
                                                      //           color: Color
                                                      //               .fromARGB(
                                                      //                   255,
                                                      //                   248,
                                                      //                   132,
                                                      //                   134),
                                                      //           fontSize: width <
                                                      //                   700
                                                      //               ? width / 40
                                                      //               : width /
                                                      //                   45,
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .w600,
                                                      //           letterSpacing:
                                                      //               0),
                                                      // ),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                      Divider()
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        error: (err, s) => Center(child: Text("No Datas Available ${s}")),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../const/global_colors.dart';

class ServiceTaskDetailsSCreen extends ConsumerStatefulWidget {
  const ServiceTaskDetailsSCreen({Key? key}) : super(key: key);

  @override
  _ServiceTaskDetailsSCreenState createState() =>
      _ServiceTaskDetailsSCreenState();
}

class _ServiceTaskDetailsSCreenState
    extends ConsumerState<ServiceTaskDetailsSCreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final taskDetail = ref.watch(serviceTaskDetailsProvider);
    return taskDetail.when(
        data: (_data) {
          return Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  children: [
                    Card(
                      elevation: 10,
                      color: Color.fromARGB(255, 251, 242, 243),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(color: GlobalColors.themeColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "TaskDetails ",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.themeColor,
                              fontSize: width < 700 ? width / 35 : width / 45,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: GlobalColors.themeColor2),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(
                        minHeight: height * 0.1, minWidth: width),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: width * 0.2,
                              child: Text(
                                "Category   ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                            Container(width: width * 0.1, child: Text(":")),
                            Expanded(
                              child: Text(
                                "${_data.category!.name}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: width * 0.2,
                              child: Text(
                                "Start Date ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                            Container(width: width * 0.1, child: Text(":")),
                            Expanded(
                              child: Text(
                                _data.startDate == null
                                    ? "--"
                                    : "${DateFormat("dd-MM-yyyy").format(_data.startDate!)}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: width * 0.2,
                              child: Text(
                                "End Date   ",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                            Container(width: width * 0.1, child: Text(":")),
                            Expanded(
                              child: Text(
                                _data.endDate == null
                                    ? "--"
                                    : _data.endDate is String
                                        ? "${DateFormat("dd - MMMM - yyyy ").format(DateTime.parse(_data.endDate!))}"
                                        : "${DateFormat("dd - MMMM - yyyy ").format(_data.endDate!)}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: width * 0.2,
                              child: Text(
                                "Description",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 38 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                            Container(width: width * 0.1, child: Text(":")),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Center(
                                child: HtmlWidget(
                                  _data.taskDescription ?? "--",
                                  textStyle: GoogleFonts.ptSans(
                                      fontSize:
                                          width < 700 ? width / 38 : width / 45,
                                      fontWeight: FontWeight.w800,
                                      color: GlobalColors.themeColor,
                                      letterSpacing: 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        if (_data.isRemovable != 0)
                          Row(
                            children: [
                              Container(
                                width: width * 0.2,
                                child: Text(
                                  "Removable Quantity",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.black,
                                      fontSize:
                                          width < 700 ? width / 38 : width / 45,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                                ),
                              ),
                              Container(width: width * 0.1, child: Text(":")),
                              Expanded(
                                child: Text(
                                  "${_data.removeableCount ?? "--"}",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.themeColor,
                                      fontSize:
                                          width < 700 ? width / 38 : width / 45,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                if (_data.isRemovable != 0)
                  Expanded(
                    child: Text(""),
                  ),
                if (_data.isRemovable == 0)
                  Row(
                    children: [
                      Card(
                        elevation: 10,
                        color: Color.fromARGB(255, 251, 242, 243),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: GlobalColors.themeColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Product Details ",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor,
                                fontSize: width < 700 ? width / 35 : width / 45,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_data.isRemovable == 0)
                  Expanded(
                    child: Card(
                      elevation: 10,
                      child: Container(
                        width: width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Card(
                                child: Container(
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
                                          child: Text(
                                            "Product Name",
                                            style: GoogleFonts.ptSans(
                                                color: Color.fromARGB(
                                                    255, 104, 100, 100),
                                                fontSize: width < 700
                                                    ? width / 38
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
                                          child: Text(
                                            "Unit",
                                            style: GoogleFonts.ptSans(
                                                color: Color.fromARGB(
                                                    255, 104, 100, 100),
                                                fontSize: width < 700
                                                    ? width / 38
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
                                          child: Text(
                                            "Quantity",
                                            style: GoogleFonts.ptSans(
                                                color: Color.fromARGB(
                                                    255, 104, 100, 100),
                                                fontSize: width < 700
                                                    ? width / 38
                                                    : width / 45,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              for (var i = 0; i < _data.items!.length; i++)
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                      side: BorderSide(
                                          color: GlobalColors.themeColor2)),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${_data.items![i].product!.name}",
                                                  style: GoogleFonts.ptSans(
                                                      color: GlobalColors.black,
                                                      fontSize: width < 700
                                                          ? width / 38
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      color: GlobalColors.black,
                                                      fontSize: width < 700
                                                          ? width / 38
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                      color: GlobalColors.black,
                                                      fontSize: width < 700
                                                          ? width / 38
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        if (_data.items![i].serialNo != null)
                                          Container(
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
                                                          ? width / 38
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0),
                                                ),
                                                Wrap(
                                                  children: [
                                                    Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          side: BorderSide(
                                                              color:
                                                                  GlobalColors
                                                                      .black)),
                                                      elevation: 4,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "${_data.items![i].serialNo}",
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .black,
                                                              fontSize: width <
                                                                      700
                                                                  ? width / 38
                                                                  : width / 45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing: 0),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        SizedBox(height: 4),
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
                                                              ? width / 38
                                                              : width / 45,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                side: BorderSide(
                                                                    color: GlobalColors
                                                                        .black)),
                                                            elevation: 4,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "${_data.items![i].serialnos![j]["serial_no"]}",
                                                                style: GoogleFonts.ptSans(
                                                                    color: GlobalColors
                                                                        .black,
                                                                    fontSize: width <
                                                                            700
                                                                        ? width /
                                                                            38
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
                                                      ],
                                                    ),
                                                  ],
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

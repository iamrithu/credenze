import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/add-workupdate.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WorkUpdateDetailsScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;
  final int? id;

  const WorkUpdateDetailsScreen({
    Key? key,
    required this.height,
    required this.width,
    required this.id,
  }) : super(key: key);

  @override
  ConsumerState<WorkUpdateDetailsScreen> createState() =>
      _WorkUpdateDetailsScreenState();
}

class _WorkUpdateDetailsScreenState
    extends ConsumerState<WorkUpdateDetailsScreen> {
  Map<String, dynamic> data = {};

  getDetails() {
    Api()
        .getWorkUpdateDetails(
            ref.read(newToken)!, ref.read(overViewId), widget.id!)
        .then((value) {
      setState(() {
        data = value.data["data"];
      });
      print(data.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalColors.white,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: widget.height! * 0.08),
        padding: EdgeInsets.symmetric(vertical: 20),
        width: width,
        height: height,
        color: GlobalColors.white,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.all(1),
          child: data.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "-- Data not found --",
                      style: GoogleFonts.ptSans(
                          fontSize: width < 700 ? width / 40 : width / 45,
                          fontWeight: FontWeight.w800,
                          color: Color.fromARGB(255, 50, 49, 49),
                          letterSpacing: 0),
                    ),
                  ],
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        color: GlobalColors.themeColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Work Update Details",
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 40 : width / 45,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 255, 250, 250),
                                  letterSpacing: 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: GlobalColors.themeColor2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Date",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 50, 49, 49),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.02,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: Text(
                                    DateFormat("dd-MM-yyyy").format(
                                        DateTime.parse(
                                            data["workupdate_date"])),
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Participants",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 50, 49, 49),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.02,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: Text(
                                    data["participants_name"].toString(),
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Task",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 50, 49, 49),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.02,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: Text(
                                    data["category"]["name"].toString(),
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            if (data["is_removable_task"] == 1)
                              SizedBox(
                                height: 10,
                              ),
                            if (data["is_removable_task"] == 1)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.2,
                                    child: Text(
                                      "Completed Quantity",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 40
                                              : width / 45,
                                          fontWeight: FontWeight.w800,
                                          color:
                                              Color.fromARGB(255, 50, 49, 49),
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.02,
                                    child: Text(
                                      ":",
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 40
                                              : width / 45,
                                          fontWeight: FontWeight.w800,
                                          color: GlobalColors.themeColor2,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.4,
                                    child: Text(
                                      data["removed_quantity"].toString(),
                                      style: GoogleFonts.ptSans(
                                          fontSize: width < 700
                                              ? width / 40
                                              : width / 45,
                                          fontWeight: FontWeight.w600,
                                          color: GlobalColors.black,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Site Incharge",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 50, 49, 49),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.02,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: Text(
                                    data["siteincharge"]["name"].toString(),
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: width * 0.2,
                                  child: Text(
                                    "Description",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: Color.fromARGB(255, 50, 49, 49),
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.02,
                                  child: Text(
                                    ":",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w800,
                                        color: GlobalColors.themeColor2,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  width: width * 0.4,
                                  child: Text(
                                    data["description"] ?? "--",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 40
                                            : width / 45,
                                        fontWeight: FontWeight.w600,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (data["items"].length > 0)
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.4,
                                        color: GlobalColors.themeColor2,
                                        padding: EdgeInsets.all(4),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Product Name",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 40
                                                  : width / 45,
                                              fontWeight: FontWeight.w800,
                                              color: GlobalColors.white,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.2,
                                        color: GlobalColors.themeColor2,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          "Unit	",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 40
                                                  : width / 45,
                                              fontWeight: FontWeight.w800,
                                              color: GlobalColors.white,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        color: GlobalColors.themeColor2,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          "	Completed Quantity",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 40
                                                  : width / 45,
                                              fontWeight: FontWeight.w600,
                                              color: GlobalColors.white,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var j = 0; j < data["items"].length; j++)
                                    Container(
                                      width: width,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.4,
                                                padding: EdgeInsets.all(4),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  textAlign: TextAlign.left,
                                                  "${data["items"][j]["product"]["name"]}",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 40
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: GlobalColors.black,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.2,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                  "${data["items"][j]["unit"]["short_name"]}",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 40
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: GlobalColors.black,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.3,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(4),
                                                child: Text(
                                                  "${data["items"][j]["quantity"]}",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 40
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: GlobalColors.black,
                                                      letterSpacing: 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (data["items"][j]
                                                  ["enable_barcode"] ==
                                              1)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "S.NO",
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: width < 700
                                                            ? width / 40
                                                            : width / 45,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: GlobalColors
                                                            .themeColor,
                                                        letterSpacing: 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (data["items"][j]
                                                  ["enable_barcode"] ==
                                              1)
                                            Container(
                                              width: width,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      for (var k = 0;
                                                          k <
                                                              data["items"][j][
                                                                      "itemsbarcodes"]
                                                                  .length;
                                                          k++)
                                                        Card(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              4),
                                                                  side:
                                                                      BorderSide(
                                                                    color: GlobalColors
                                                                        .themeColor2,
                                                                  )),
                                                          shadowColor:
                                                              Color.fromARGB(
                                                                  255, 0, 0, 0),
                                                          elevation: 2,
                                                          child: Container(
                                                            width: width * 0.3,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${data["items"][j]["itemsbarcodes"][k]["serial_nos"]}",
                                                              style: GoogleFonts.ptSans(
                                                                  fontSize: width <
                                                                          700
                                                                      ? width /
                                                                          40
                                                                      : width /
                                                                          45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color:
                                                                      GlobalColors
                                                                          .black,
                                                                  letterSpacing:
                                                                      0),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              textAlign: TextAlign.center,
                              "Back",
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 40 : width / 45,
                                  fontWeight: FontWeight.w800,
                                  color: GlobalColors.white,
                                  letterSpacing: 0),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

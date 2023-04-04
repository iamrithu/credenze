import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../apis/api.dart';
import '../../const/global_colors.dart';
import '../../river-pod/riverpod_provider.dart';

class MainTaskScreen extends ConsumerStatefulWidget {
  const MainTaskScreen({Key? key}) : super(key: key);

  @override
  _MainTaskScreenState createState() => _MainTaskScreenState();
}

class _MainTaskScreenState extends ConsumerState<MainTaskScreen> {
  List<dynamic> taksList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Api().publicTask(ref.read(newToken)!).then((value) {
      setState(() {
        taksList = value.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          if (taksList.isEmpty)
            Container(
              width: width,
              height: height * 0.1,
              child: Center(child: Text("--Empty--")),
            ),
          if (taksList.isNotEmpty)
            for (var i = 0; i < taksList.length; i++)
              InkWell(
                onTap: () {
                  ref.read(pageIndex.notifier).update((state) => 9);
                  ref
                      .read(publicTaskId.notifier)
                      .update((state) => taksList[i]["id"]);
                },
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: GlobalColors.themeColor)),
                  child: Container(
                    padding: EdgeInsets.all(width * 0.03),
                    width: width * 0.965,
                    height: height * 0.25,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Brance",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${taksList[i]["branch"]["location"] ?? "--"}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Category",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${taksList[i]["category"]["category_name"] ?? "--"}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Start Date",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(taksList[i]["start_date"]))}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Due Date ",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(taksList[i]["due_date"]))}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Status",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${taksList[i]["status"] ?? "--"}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Text(
                                    "Priority",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Text(":"),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: width * 0.45,
                                  child: Text(
                                    "${taksList[i]["priority"] ?? "--"}",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/global_colors.dart';
import '../../river-pod/riverpod_provider.dart';

class MainTaskScreen extends ConsumerStatefulWidget {
  const MainTaskScreen({Key? key}) : super(key: key);

  @override
  _MainTaskScreenState createState() => _MainTaskScreenState();
}

class _MainTaskScreenState extends ConsumerState<MainTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              ref.read(pageIndex.notifier).update((state) => 9);
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "Covai",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "Others",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "31-03-2023",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "30-03-2023",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "Assigend",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "rithi",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "Incomplete",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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
                                "Medium",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
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

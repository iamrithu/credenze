import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/global_colors.dart';

class MainExpenseScreen extends StatefulWidget {
  const MainExpenseScreen({Key? key}) : super(key: key);

  @override
  _MainExpenseScreenState createState() => _MainExpenseScreenState();
}

class _MainExpenseScreenState extends State<MainExpenseScreen> {
  String cat = "Petrol";
  bool chooseCat = false;
  bool openForm = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.4,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height * 0.4,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * 0.32,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          Row(
                            children: [Text("rithi"), Text("rithi")],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.04,
                    child: Center(
                      child: ElevatedButton(
                        child: Text("Add Expense"),
                        onPressed: () {
                          setState(() {
                            openForm = true;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (openForm)
            Card(
              elevation: 10,
              margin: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                width: width,
                height: height * 0.5,
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.5,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Today's Expenses :",
                                style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 27 : width / 48,
                                    fontWeight: FontWeight.w500,
                                    color: GlobalColors.themeColor,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: Row(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.25,
                                child: Text(
                                  "Category",
                                  style: GoogleFonts.ptSans(
                                      fontSize:
                                          width < 700 ? width / 30 : width / 48,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.black,
                                      letterSpacing: 0),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.05,
                                child: Text(":"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseCat = true;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    child: Center(
                                      child: Text(
                                        "${cat}",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 30
                                                : width / 48,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: Row(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.25,
                                child: Text(
                                  "Category",
                                  style: GoogleFonts.ptSans(
                                      fontSize:
                                          width < 700 ? width / 30 : width / 48,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.black,
                                      letterSpacing: 0),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.05,
                                child: Text(":"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseCat = true;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    child: Center(
                                      child: Text(
                                        "${cat}",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 30
                                                : width / 48,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: Row(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.25,
                                child: Text(
                                  "Category",
                                  style: GoogleFonts.ptSans(
                                      fontSize:
                                          width < 700 ? width / 30 : width / 48,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.black,
                                      letterSpacing: 0),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.05,
                                child: Text(":"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseCat = true;
                                  });
                                },
                                child: Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    child: Center(
                                      child: Text(
                                        "${cat}",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 30
                                                : width / 48,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.themeColor,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: width,
                            height: height * 0.08,
                            color: Colors.amber,
                            child: Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        openForm = false;
                                      });
                                    },
                                    child: Text("Save"))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (chooseCat)
            Container(
              width: width,
              height: height * 0.5,
              color: Color.fromARGB(95, 71, 70, 70),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width,
                height: height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          cat = "Petrol";
                          chooseCat = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: width,
                          height: height * 0.05,
                          child: Center(
                            child: Text(
                              "Petrol",
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 30 : width / 48,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.themeColor,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          cat = "Food";
                          chooseCat = false;
                        });
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: width,
                          height: height * 0.05,
                          child: Center(
                            child: Text(
                              "Food",
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 30 : width / 48,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.themeColor,
                                  letterSpacing: 0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

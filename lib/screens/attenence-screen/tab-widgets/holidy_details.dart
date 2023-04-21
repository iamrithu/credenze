import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../apis/api.dart';
import '../../../const/global_colors.dart';

class HolidayDetailsScreen extends ConsumerStatefulWidget {
  const HolidayDetailsScreen({Key? key}) : super(key: key);

  @override
  _HolidayDetailsScreenState createState() => _HolidayDetailsScreenState();
}

class _HolidayDetailsScreenState extends ConsumerState<HolidayDetailsScreen> {
  DateTime newDate = DateTime.now();
  List<dynamic> holidays = [];

  getHoliday() {
    print(DateFormat("MM").format(newDate));
    print(DateFormat("yyyy").format(newDate));

    Api()
        .getHoliday(ref.read(newToken)!, DateFormat("yyyy").format(newDate),
            DateFormat("MM").format(newDate))
        .then((value) {
      setState(() {
        holidays = value.data["data"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHoliday();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            width: width,
            height: width < 500 ? height * 0.05 : height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: DateFormat("MMMM").format(newDate),
                      style: GoogleFonts.ptSans(
                          fontSize: width < 700 ? width / 16 : width / 22,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.themeColor2,
                          letterSpacing: 2),
                      children: [
                        TextSpan(
                          text: " - " + newDate.year.toString(),
                          style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 22 : width / 45,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.black,
                            letterSpacing: 2,
                          ),
                        ),
                      ]),
                ),
                GestureDetector(
                  onTap: () async {
                    final month = await showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      print(value.toString());
                      if(value!=null){
                           setState(() {
                    newDate = value;
                  });
                   getHoliday();
                      }
                    });

                    if (month != null) {
                      setState(() {
                        newDate = month;
                      });
                    }
                  },
                  child: Text(
                    "Pick Date",
                    style: GoogleFonts.ptSans(
                        fontSize: width < 700 ? width / 28 : width / 45,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: width,
              height: width < 500 ? height * 0.633 : height * 0.66,
              child: RefreshIndicator(
                onRefresh: () {
                  setState(() {
                    newDate = DateTime.now();
                  });
                  return Future.delayed(Duration(seconds: 2), () {
                    return getHoliday();
                  });
                },
                child: ListView(
                  children: [
                    if(holidays.isEmpty)
                    Center(
                      child:  Text(
                    "-- No holidays --",
                    style: GoogleFonts.ptSans(
                      color: GlobalColors.themeColor2,
                        fontSize: width < 700 ? width / 28 : width / 45,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0),
                  ),
                    ),
                    for (var i = 0; i < holidays.length; i++)
                      Card(
                        elevation: 1,
                        child: Container(
                          width: width,
                          height: height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.3,
                                height: height * 0.06,
                                alignment: Alignment.center,
                                child: Wrap(children: [
                                  Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(holidays[i]["date"]))}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.themeColor,
                                        letterSpacing: 0),
                                  ),
                                ]),
                              ),
                              Container(
                                width: width * 0.3,
                                height: height * 0.06,
                                alignment: Alignment.center,
                                child: Wrap(children: [
                                  Text(
                                    "${holidays[i]["occassion"]}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0),
                                  ),
                                ]),
                              ),
                              Container(
                                width: width * 0.3,
                                height: height * 0.06,
                                alignment: Alignment.center,
                                child: Wrap(children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

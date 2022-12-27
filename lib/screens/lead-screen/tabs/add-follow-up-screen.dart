import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/custom-widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddFollowUpScreen extends StatefulWidget {
  const AddFollowUpScreen({Key? key}) : super(key: key);

  @override
  _AddFollowUpScreenState createState() => _AddFollowUpScreenState();
}

class _AddFollowUpScreenState extends State<AddFollowUpScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  onSelectedDates(context, value) {
    setState(() {
      value == null ? _selectedDate = DateTime.now() : _selectedDate = value;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height * 0.45,
        padding: EdgeInsets.only(right: 4, left: 8),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: GlobalColors.themeColor, width: 3))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width,
              height: height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Follow Up",
                    style: GoogleFonts.ptSans(
                      color: GlobalColors.themeColor2,
                      fontSize: width < 700 ? width / 20 : width / 41,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.06,
              child: Row(
                children: [
                  Container(
                      width: width * 0.35,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Next Follow Up Date",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 27 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.45,
                      height: height * 0.06,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: GlobalColors.themeColor2)),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text: _selectedDate.day.toString() + " ",
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 22 : width / 40,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.themeColor,
                                  letterSpacing: 2),
                              children: [
                                TextSpan(
                                  text: DateFormat("MMMM yyyy")
                                      .format(_selectedDate),
                                  style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 28 : width / 49,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.black,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ]),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: width,
                            height: height * 0.4,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: GlobalColors.themeColor,
                                        width: 3))),
                            child: SfDateRangePicker(
                              view: DateRangePickerView.month,
                              toggleDaySelection: true,
                              navigationDirection:
                                  DateRangePickerNavigationDirection.vertical,
                              selectionShape:
                                  DateRangePickerSelectionShape.rectangle,
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 7,
                              ),
                              showActionButtons: true,
                              onSubmit: (value) {
                                onSelectedDates(context, value);
                              },
                              onCancel: () => Navigator.pop(context),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                        width: width * 0.15,
                        margin: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: GlobalColors.themeColor2),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(FontAwesomeIcons.calendarCheck,
                              color: GlobalColors.themeColor),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.06,
              child: Row(
                children: [
                  Container(
                      width: width * 0.35,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Next Follow Up Time",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 27 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.45,
                      height: height * 0.06,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: GlobalColors.themeColor2)),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                              text: _time.format(context).toString(),
                              style: GoogleFonts.ptSans(
                                  fontSize:
                                      width < 700 ? width / 28 : width / 40,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.black,
                                  letterSpacing: 2),
                              children: [
                                TextSpan(
                                  text: "",
                                  style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 28 : width / 49,
                                    fontWeight: FontWeight.w400,
                                    color: GlobalColors.black,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ]),
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      ).then((value) {
                        setState(() {
                          _time = value!;
                        });
                      });
                    },
                    child: Container(
                        width: width * 0.15,
                        margin: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: GlobalColors.themeColor2),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(FontAwesomeIcons.clock,
                              color: GlobalColors.themeColor),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.27,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Remarks",
                      style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 25 : width / 44,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  Container(
                      width: width * 0.615,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.themeColor2),
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your reason.. ",
                        ),
                        maxLines: 5,
                      )),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.08,
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.themeColor2),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel),
                    label: Text(
                      " Cancel",
                      style: GoogleFonts.ptSans(
                          fontSize: width < 700 ? width / 28 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "Add ",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 28 : width / 45,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

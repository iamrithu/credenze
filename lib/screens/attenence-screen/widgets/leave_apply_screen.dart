import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/custom-widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

const List<String> leaveTypeList = <String>['Casual', 'Sick', 'Earned'];
const List<String> leaveDuration = <String>[
  'One Day',
  'Multiple Days',
  'Forenoon',
  'Afternoon'
];

class LeaveApplyScreen extends StatefulWidget {
  const LeaveApplyScreen({Key? key}) : super(key: key);

  @override
  _LeaveApplyScreenState createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends State<LeaveApplyScreen> {
  String _leaveType = leaveTypeList[0];
  String _leaveDuration = leaveDuration[0];
  bool singleday = true;
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _selectedDateList = [];

  leaveType(value) {
    setState(() {
      _leaveType = value;
    });
  }

  leaveduration(value) {
    setState(() {
      _leaveDuration = value;
    });
    if (_leaveDuration == 'Multiple Days') {
      setState(() {
        singleday = false;
      });
    } else {
      singleday = true;
    }
  }

  onSelectedDates(context, value) {
    if (singleday) {
      setState(() {
        value == null ? _selectedDate = DateTime.now() : _selectedDate = value;
      });
    } else {
      setState(() {
        _selectedDateList = value!;
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(right: 4, left: 8),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: GlobalColors.themeColor, width: 3))),
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Leave Form",
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
              height: height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Leave Type",
                      style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 25 : width / 44,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  CustomDropDownButton(
                      leaveType: _leaveType,
                      leaveTypeList: leaveTypeList,
                      function: leaveType)
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Leave Duration",
                      style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 25 : width / 44,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  CustomDropDownButton(
                      leaveType: _leaveDuration,
                      leaveTypeList: leaveDuration,
                      function: leaveduration)
                ],
              ),
            ),
            Container(
              width: width,
              height: singleday ? height * 0.06 : height * 0.15,
              child: Row(
                children: [
                  Container(
                    width: width * 0.308,
                    alignment: Alignment.centerLeft,
                    child: singleday
                        ? Text(
                            "Selected Date",
                            style: GoogleFonts.ptSans(
                              color: GlobalColors.black,
                              fontSize: width < 700 ? width / 25 : width / 44,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                          )
                        : Text(
                            "Selected Date " + "(${_selectedDateList.length})",
                            style: GoogleFonts.ptSans(
                              color: GlobalColors.black,
                              fontSize: width < 700 ? width / 25 : width / 44,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                          ),
                  ),
                  Container(
                    width: width * 0.49,
                    height: singleday ? height * 0.06 : height * 0.2,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2)),
                    child: singleday
                        ? Center(
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
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 49,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        : ListView(
                            children: [
                              if (_selectedDateList.length == 0)
                                Center(
                                    child: Text("Choose one or more date...")),
                              for (var i = 0; i < _selectedDateList.length; i++)
                                Container(
                                  margin: EdgeInsets.all(5),
                                  width: width,
                                  height: height * 0.04,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: GlobalColors.themeColor2)),
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          text: _selectedDateList[i]
                                                  .day
                                                  .toString() +
                                              " ",
                                          style: GoogleFonts.ptSans(
                                              fontSize: width < 700
                                                  ? width / 22
                                                  : width / 40,
                                              fontWeight: FontWeight.w400,
                                              color: GlobalColors.themeColor,
                                              letterSpacing: 2),
                                          children: [
                                            TextSpan(
                                              text: DateFormat("MMMM yyyy")
                                                  .format(_selectedDateList[i]),
                                              style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 28
                                                    : width / 49,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.black,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                )
                            ],
                          ),
                  ),
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
                              selectionMode: singleday
                                  ? DateRangePickerSelectionMode.single
                                  : DateRangePickerSelectionMode.multiple,
                              monthViewSettings:
                                  DateRangePickerMonthViewSettings(
                                      firstDayOfWeek: 7),
                              // onSelectionChanged: onSelectedDates,
                              showActionButtons: true,

                              onSubmit: (value) =>
                                  onSelectedDates(context, value),
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
            Expanded(
              child: Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * 0.25,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reason",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 25 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Container(
                        width: width * 0.66,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: GlobalColors.themeColor2),
                            borderRadius: BorderRadius.circular(4)),
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your reason.. ",
                          ),
                          maxLines: 10,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              height: height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Add Leave",
                      style: GoogleFonts.ptSans(
                          fontSize: width < 700 ? width / 28 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

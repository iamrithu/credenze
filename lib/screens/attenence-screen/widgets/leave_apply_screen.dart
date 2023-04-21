import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/custom-widget/custom_input.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../apis/api.dart';

List<String> leaveTypeList = <String>["--"];
List<String> leaveDuration = <String>["--"];
List<dynamic> leaveTypeListRaw = [];

class LeaveApplyScreen extends ConsumerStatefulWidget {
  const LeaveApplyScreen({Key? key}) : super(key: key);

  @override
  _LeaveApplyScreenState createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends ConsumerState<LeaveApplyScreen> {
  String _leaveType = leaveTypeList[0];
  int _leaveId = 0;
  String _leaveDuration = leaveDuration[0];
  String reason = "";
  bool singleday = true;
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _selectedDateList = [];

  leaveType(value) {
    setState(() {
      _leaveType = value;
    });
    for (var i = 0; i < leaveTypeListRaw.length; i++) {
      setState(() {
        if (leaveTypeListRaw[i]["type_name"] == _leaveType) {
          return _leaveId = leaveTypeListRaw[i]["id"];
        }
      });
    }
  }

  leaveduration(value) {
    setState(() {
      _leaveDuration = value;
    });
    if (_leaveDuration == 'multiple') {
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

  getDuration() {
    Api().leaveDuration(ref.read(newToken)!).then((value) {
      setState(() {
        leaveDuration = ["--"];
        value.data["data"].map((e) => leaveDuration.add(e)).toList();

        leaveDuration.toSet().toList();
      });
    });
  }

  getType() {
    Api().leaveType(ref.read(newToken)!).then((value) {
      setState(() {
        leaveTypeList = ["--"];
        leaveTypeListRaw = value.data["data"];
        value.data["data"]
            .map((e) => leaveTypeList.add(e["type_name"]))
            .toList();
      });
    });
  }

  addLeave() {
    if (_leaveType == "--") {
      return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Choose \"Leave Type\"",
          autoCloseDuration: null);
    }
    if (_leaveDuration == "--") {
      return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Choose \"Leave Duration\"",
          autoCloseDuration: null);
    }
    if (_leaveDuration == 'multiple') {
      if (_selectedDateList.length < 1) {
        return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "Select one or more dates",
            autoCloseDuration: null);
      }
    }

    Api()
        .addLeave(
            ref.read(newToken)!,
            _leaveId,
            _leaveDuration,
            reason,
            _leaveDuration == 'multiple' ? null : _selectedDate,
            _leaveDuration == 'single' ? null : _selectedDateList)
        .then((value) {
      print(value.statusCode.toString());
      if (value.statusCode == 401) {
        Navigator.pop(context);

        return QuickAlert.show(
            context: context,
            type: QuickAlertType.info,
            title: "${value.data["message"]}",
            autoCloseDuration: Duration(seconds: 2));
      }
      if (value.statusCode == 200) {
        Navigator.pop(context);
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: "${value.data["message"]}",
            autoCloseDuration: Duration(seconds: 2));
        return ref.refresh(leaveListModelProvider);

      } else {
        return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: "${value.data["error"]["message"]}",
            autoCloseDuration: Duration(seconds: 2));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDuration();
    getType();
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
                      "Leave Type*",
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
                      "Leave Duration*",
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
                            "Selected Date*",
                            style: GoogleFonts.ptSans(
                              color: GlobalColors.black,
                              fontSize: width < 700 ? width / 25 : width / 44,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                          )
                        : Text(
                            "Selected Date*" + "(${_selectedDateList.length})",
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
                          onChanged: (value) {
                            setState(() {
                              reason = value;
                            });
                          },
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
                      addLeave();
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

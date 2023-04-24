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

class PermissionApplyScreen extends ConsumerStatefulWidget {
  const PermissionApplyScreen({Key? key}) : super(key: key);

  @override
  _PermissionApplyScreenState createState() => _PermissionApplyScreenState();
}

class _PermissionApplyScreenState extends ConsumerState<PermissionApplyScreen> {
  int _leaveId = 0;
  String _leaveDuration = leaveDuration[0];
  String reason = "";
  bool singleday = true;
  DateTime _selectedDate = DateTime.now();
  String toDate = "--";

  String fromDate = "--";
  List<DateTime> _selectedDateList = [];

  onSelectedDates(context, value) {
    setState(() {
      value == null ? _selectedDate = DateTime.now() : _selectedDate = value;
    });

    Navigator.pop(context);
  }

  addLeave() {
    if (toDate.trim() == "--") {
      return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Choose \"To Time\"",
          autoCloseDuration: null);
    }
    if (fromDate.trim() == "--") {
      return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "Choose \"From Time\"",
          autoCloseDuration: null);
    }
    Api()
        .addPermission(
            ref.watch(newToken)!,
            toDate,
            fromDate,
            DateFormat("dd-MM-yyyy").format(_selectedDate),
            reason,
            ref.watch(userId))
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
        return ref.refresh(permissionListModelProvider);
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
                    "Permission Form",
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
            SizedBox(height: 10),
            Container(
              width: width,
              height: singleday ? height * 0.06 : height * 0.15,
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date*",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 25 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.49,
                      height: singleday ? height * 0.06 : height * 0.2,
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
            SizedBox(height: 10),
            Container(
              width: width,
              height: singleday ? height * 0.06 : height * 0.15,
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "From Time*",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 25 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.49,
                      height: singleday ? height * 0.06 : height * 0.2,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: GlobalColors.themeColor2)),
                      child: Center(child: Text(fromDate))),
                  GestureDetector(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        // print("${value!.hour>12?value.hour-12:value.hour}:${value.minute<10?"0${value.minute}":value.minute} ${value.hour>11?"PM":"AM"}");
                        if (value != null)
                          setState(() {
                            fromDate =
                                "${value.hour == 0 ? "12" : value.hour > 12 ? value.hour - 12 : value.hour}:${value.minute < 10 ? "0${value.minute}" : value.minute} ${value.hour > 11 ? "PM" : "AM"}";
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
            SizedBox(height: 10),
            Container(
              width: width,
              height: singleday ? height * 0.06 : height * 0.15,
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "To Time*",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 25 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.49,
                      height: singleday ? height * 0.06 : height * 0.2,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: GlobalColors.themeColor2)),
                      child: Center(child: Text(toDate))),
                  GestureDetector(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: false),
                            child: child!,
                          );
                        },
                      ).then((value) {
                        if (value != null)
                          setState(() {
                            toDate =
                                "${value.hour == 0 ? "12" : value.hour > 12 ? value.hour - 12 : value.hour}:${value.minute < 10 ? "0${value.minute}" : value.minute} ${value.hour > 11 ? "PM" : "AM"}";
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
            SizedBox(height: 10),
            Container(
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
                      height: height * 0.06,
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
            SizedBox(height: 10),
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
                      "Add Permission",
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

import 'dart:convert';
import 'dart:io';

import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/custom-widget/custom_input.dart';
import 'package:credenze/models/expense-category-model.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../lead-screen/tabs/widgets/lead_custom_input.dart';
import '../../../lead-screen/tabs/widgets/lead_custom_lable.dart';

List<String> place = ["Office", "Home"];

class ExpenseAddScreen extends ConsumerStatefulWidget {
  final List<String> cat;
  final List<ExpenseCategoryModel> data;
  const ExpenseAddScreen({Key? key, required this.cat, required this.data})
      : super(key: key);

  @override
  _ExpenseAddScreenState createState() => _ExpenseAddScreenState();
}

class _ExpenseAddScreenState extends ConsumerState<ExpenseAddScreen> {
  late String _category;
  late int? _categoryId = 1;
  late int? _placeId = 1;

  String selectedPlace = place[0];

  DateTime _selectedDate = DateTime.now();
  late TextEditingController _amount = TextEditingController();
  late TextEditingController _note = TextEditingController();
  late TextEditingController _distance = TextEditingController();

  File? newFile = null;
  placeType(value) {
    setState(() {
      selectedPlace = value;

      selectedPlace == "Office" ? _placeId = 1 : _placeId = 2;
    });

    print(_placeId.toString());
  }

  leaveType(value) {
    setState(() {
      _category = value;
    });

    final list = widget.data;
    var newdata = list.firstWhere(((element) => element.name == _category));
    setState(() {
      _categoryId = newdata.id!;
    });
  }

  onSelectedDates(context, value) {
    setState(() {
      _selectedDate = value;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _category = widget.cat[0];
    });
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
              height: height * 0.06,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Expense Category",
                      style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 35 : width / 44,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  CustomDropDownButton(
                      leaveType: _category,
                      leaveTypeList: widget.cat,
                      function: leaveType)
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.06,
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      height: height * 0.05,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Selecte Date",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 35 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                      width: width * 0.49,
                      height: height * 0.05,
                      margin: EdgeInsets.only(left: 5, right: 2),
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
                        height: height * 0.05,
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
            if (_categoryId != 1)
              Container(
                width: width,
                height: height * 0.057,
                margin: EdgeInsets.only(bottom: height * 0.01),
                child: Row(
                  children: [
                    LeadCustomlabel(
                      label: "Amount",
                      start: "*",
                    ),
                    LeadCustomInput(
                      label: "Amount",
                      controller: _amount,
                    ),
                  ],
                ),
              ),
            if (_categoryId == 1)
              Container(
                width: width,
                height: height * 0.057,
                child: Row(
                  children: [
                    LeadCustomlabel(
                      label: "From Place",
                      start: "*",
                    ),
                    CustomDropDownButton(
                        leaveType: selectedPlace,
                        leaveTypeList: place,
                        function: placeType),
                  ],
                ),
              ),
            if (_categoryId == 1)
              Container(
                width: width,
                height: height * 0.057,
                margin: EdgeInsets.symmetric(vertical: height * 0.01),
                child: Row(
                  children: [
                    LeadCustomlabel(
                      label: "Enter KM",
                      start: "*",
                    ),
                    LeadCustomInput(
                      label: "Eg: 12",
                      controller: _distance,
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
                      width: width * 0.30,
                      height: height * 0.05,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: width * 0.01),
                      child: Text(
                        "File ",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 35 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Container(
                    width: width * 0.493,
                    height: height * 0.05,
                    margin: EdgeInsets.only(left: 5, right: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2)),
                    child: Container(
                      width: width * 0.2,
                      child: newFile == null
                          ? Center(
                              child: Text(
                                "Choose File ",
                                style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor2,
                                  fontSize:
                                      width < 700 ? width / 35 : width / 44,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            )
                          : Image.file(
                              newFile!,
                              width: width * 1,
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        setState(() {
                          newFile = file;
                        });
                      } else {}
                    },
                    child: Container(
                        width: width * 0.15,
                        height: height * 0.05,
                        margin: EdgeInsets.symmetric(vertical: 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: GlobalColors.themeColor2),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: Icon(FontAwesomeIcons.file,
                              color: GlobalColors.themeColor),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  LeadCustomlabel(
                    label: "Notes",
                    start: null,
                  ),
                  LeadCustomInput(
                    label: "Add Notes",
                    controller: _note,
                  ),
                ],
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
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      String? token = await prefs.getString('token');
                      final id = ref.watch(overViewId);

                      print(" _placeId${newFile}");
                      Api()
                          .AddExpense(
                        token: token!,
                        id: id,
                        category_id: _categoryId,
                        file: newFile == null ? File("") : newFile!,
                        date:
                            "${DateFormat("dd - MMMM - yyyy ").format(_selectedDate)}",
                        note: _note.text.isEmpty ? "--" : _note.text,
                        amount: _amount.text,
                        fromPlace: _placeId,
                        distance: _distance.text.isEmpty
                            ? 0
                            : int.parse(_distance.text),
                      )
                          .then((value) {
                        Map<String, dynamic> data = jsonDecode(value);
                        print(value.toString());
                        if (data["success"]) {
                          Navigator.pop(context);

                          return ref.refresh(expenseProvider);
                        } else {
                          Navigator.pop(context);

                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: "${data["message"]}",
                              autoCloseDuration: null);
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Add Expense",
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

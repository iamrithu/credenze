import 'dart:convert';
import 'dart:io';

import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/custom-widget/custom_input.dart';
import 'package:credenze/models/expense-category-model.dart';
import 'package:credenze/models/expenses-model.dart';
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
List<String> taskcat = [
  "Choose",
];
List<Map<String, dynamic>> participantObj = [];
List<Map<String, dynamic>> categoryObj = [];

List<String> participants = [
  "Choose",
];
List workItemKey = [];
List selectedCheckBox = [];
List selectedCheckBoxVlue = [];
List selectedItems = [];

Map<dynamic, dynamic> workItemObject = {};

class AddWorkUpdate extends ConsumerStatefulWidget {
  final List<String> cat;
  final List<ExpenseCategoryModel> data;
  final ExpensesModel? updateData;
  AddWorkUpdate(
      {Key? key,
      required this.cat,
      required this.data,
      required this.updateData})
      : super(key: key);

  @override
  _AddWorkUpdateState createState() => _AddWorkUpdateState();
}

class _AddWorkUpdateState extends ConsumerState<AddWorkUpdate> {
  late String _category = taskcat[0];
  late String _participants = participants[0];

  String selectedPlace = place[0];

  DateTime _selectedDate = DateTime.now();
  late TextEditingController _note = TextEditingController();
  List<TextEditingController> _controllers = [];

  File? newFile = null;
  participantType(value) {
    setState(() {
      _participants = value;
    });
  }

  categoryType(value) {
    setState(() {
      _category = value;
    });
  }

  onSelectedDates(context, value) {
    setState(() {
      _selectedDate = value;
    });
    Navigator.pop(context);
  }

  getWorkUpdateDetails() async {
    final int? id = ref.watch(overViewId);
    final String? date = ref.watch(selectedDate);
    final String? token = ref.watch(newToken);
    participantObj = [];
    categoryObj = [];

    Api().workUpdate(token, id, date).then((value) {
      var dataList = value["data"];
      for (var i = 0; i < dataList["taskcategories"].length; i++) {
        categoryObj.add(dataList["taskcategories"][i]);
        taskcat.add(dataList["taskcategories"][i]["name"]);
      }
      print("categoryObj $categoryObj");
      taskcat = taskcat.toSet().toList();
      for (var i = 0; i < dataList["participants"].length; i++) {
        participantObj.add(dataList["participants"][i]);
        participants.add(dataList["participants"][i]["name"]);
      }
      participants = participants.toSet().toList();

      dataList["workupdate_items"].keys.forEach((e) {
        workItemKey.add(e.toString());
      });
      workItemKey = workItemKey.toSet().toList();

      List.generate(workItemKey.length, (index) {
        _controllers.add(TextEditingController());
      });

      workItemObject = dataList["workupdate_items"];
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return GlobalColors.themeColor2;
    }
    return GlobalColors.themeColor;
  }

  addWorkUpdate() async {
    final int? id = ref.watch(overViewId);
    final int? siteIncharge = ref.watch(inChargeId);
    final String? token = ref.watch(newToken);
    print(DateFormat("dd-MM-yyyy").format(_selectedDate));
    print(_participants);
    print(_category);
    print(selectedCheckBox.toString());
    print(selectedCheckBoxVlue.toString());
    print(_controllers.toString());
    selectedItems = [];

    for (var i = 0; i < selectedCheckBox.length; i++) {
      selectedItems.add({
        "product_id": workItemObject[selectedCheckBoxVlue[i]]["product_id"],
        "unit_id": workItemObject[selectedCheckBoxVlue[i]]["unit_id"],
        "quantity": _controllers[selectedCheckBox[i]].text.toString(),
        "enable_serial_no": workItemObject[selectedCheckBoxVlue[i]]
            ["enable_serial_no"],
      });
    }
    print(participantObj.toString());
    if (_participants == "Choose") {
      return print("please add value");
    }
    if (_category == "Choose") {
      return print("please add value");
    }

    print(" ia m workinfg");

    Map<String, dynamic> newParticipant = participantObj
        .firstWhere((element) => element["name"] == _participants);
    Map<String, dynamic> newCategory =
        categoryObj.firstWhere((element) => element["name"] == _category);

    // print("$token");
    // print("$id");
    // print("${newCategory["id"]}");
    // print("${newParticipant["userid"]}");
    // print("${DateFormat("dd-MM-yyyy").format(_selectedDate)}");
    // print("${_note.text}");
    // print("$siteIncharge");
    // print(selectedItems.toString());

    Api().addWorkUpdate(
        token,
        id,
        newCategory["id"],
        DateFormat("dd-MM-yyyy").format(_selectedDate),
        newParticipant["userid"],
        _note.text,
        siteIncharge,
        selectedItems);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getWorkUpdateDetails();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(right: 4, left: 8),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: GlobalColors.themeColor, width: 3))),
        child: ListView(
          children: [
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
                      padding: EdgeInsets.only(left: width * 0.07),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: GlobalColors.themeColor2)),
                      child: RichText(
                        text: TextSpan(
                            text: _selectedDate.day.toString(),
                            style: GoogleFonts.ptSans(
                                fontSize: width < 700 ? width / 22 : width / 40,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.themeColor,
                                letterSpacing: 2),
                            children: [
                              TextSpan(
                                text: DateFormat("-MM-yyyy")
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
                      "Participants",
                      style: GoogleFonts.ptSans(
                        color: GlobalColors.black,
                        fontSize: width < 700 ? width / 35 : width / 44,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  CustomDropDownButton(
                      leaveType: _participants,
                      leaveTypeList: participants,
                      function: participantType)
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
                      "Task Category",
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
                      leaveTypeList: taskcat,
                      function: categoryType)
                ],
              ),
            ),
            Container(
              color: Color.fromARGB(255, 242, 240, 240),
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width * 0.1,
                        alignment: Alignment.center,
                        child: Text(
                          "Select",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.center,
                        child: Text(
                          "Product Name",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.1,
                        alignment: Alignment.center,
                        child: Text(
                          "unit",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.15,
                        alignment: Alignment.center,
                        child: Text(
                          "Total Qty",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Container(
                        width: width * 0.15,
                        alignment: Alignment.center,
                        child: Text(
                          "Used Qty",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < workItemKey.length; i++)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value:
                                selectedCheckBoxVlue.contains(workItemKey[i]),
                            onChanged: (bool? value) async {
                              setState(() {
                                // selectedCheckBox.add(workItemKey[i]);

                                if (selectedCheckBoxVlue
                                        .contains(workItemKey[i]) ==
                                    false) {
                                  selectedCheckBox.add(i);
                                  selectedCheckBoxVlue.add(workItemKey[i]);
                                } else {
                                  selectedCheckBoxVlue.remove(workItemKey[i]);
                                  selectedCheckBox.remove(i);
                                }

                                print(selectedCheckBox.toString());
                                print(selectedCheckBoxVlue.toString());
                              });
                            },
                          ),
                          Container(
                            width: width * 0.35,
                            alignment: Alignment.center,
                            child: Text(
                              "${workItemObject[workItemKey[i]]["product_name"]}",
                              style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 44,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            alignment: Alignment.center,
                            child: Text(
                              "${workItemObject[workItemKey[i]]["unit_name"]}",
                              style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 44,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            alignment: Alignment.center,
                            child: Text(
                              "${workItemObject[workItemKey[i]]["quantity"]}",
                              style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 35 : width / 44,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.15,
                            height: height * 0.032,
                            child: TextFormField(
                              controller: _controllers.length > 0
                                  ? _controllers[i]
                                  : null,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              readOnly: !selectedCheckBoxVlue
                                  .contains(workItemKey[i]),
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 700 ? width / 30 : width / 45,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0),
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 35 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  LeadCustomlabel(
                    label: "Description",
                    start: null,
                  ),
                  LeadCustomInput(
                    label: "Add DesCription",
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
                    onPressed: () {
                      addWorkUpdate();
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Add Work",
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

import 'dart:convert';
import 'dart:io';

import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_drop_down_button.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../lead-screen/tabs/widgets/lead_custom_input.dart';
import '../../../lead-screen/tabs/widgets/lead_custom_lable.dart';

List<String> place = ["Office", "Home"];
List<String> taskcat = [
  "Choose",
];
List<Map<String, dynamic>> participantObj = [];
List<Map<String, dynamic>> categoryObj = [];

List<String> participants = [];
List workItemKey = [];
List selectedCheckBox = [];
List selectedCheckBoxVlue = [];
List selectedItems = [];
List<String> _selectedItems = [];
List<int> _selectedUser = [];
List serialList = [];
List serialItemList = [];

Map<dynamic, dynamic> workItemObject = {};

class AddWorkUpdate extends ConsumerStatefulWidget {
  AddWorkUpdate({
    Key? key,
  }) : super(key: key);

  @override
  _AddWorkUpdateState createState() => _AddWorkUpdateState();
}

class _AddWorkUpdateState extends ConsumerState<AddWorkUpdate> {
  void _dialogBuilder(BuildContext context) async {
    final List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          tems: participants,
          onclick: getUser,
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedItems = result;
      });
    }
  }

  late String _category = taskcat[0];
  late String _participants = participants[0];

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

  getUser(List<String>? value) {
    print(value!.length.toString());
    setState(() {
      _selectedItems = value;
    });
  }

  getWorkUpdateDetails() async {
    final int? id = ref.watch(overViewId);
    final String? date = ref.watch(selectedDate);
    final String? token = ref.watch(newToken);
    participantObj = [];
    categoryObj = [];

    Api().workUpdate(token, id, date).then((value) {
      participantObj = [];

      var dataList = value["data"];
      for (var i = 0; i < dataList["taskcategories"].length; i++) {
        categoryObj.add(dataList["taskcategories"][i]);
        taskcat.add(dataList["taskcategories"][i]["name"]);
      }
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

  getSerialWidget(int id, int productId, int value) {
    if (serialList.isEmpty) return;

    serialList.add({"id": id, "productId": productId, "value": value});

    print("mahesh$serialList");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    getWorkUpdateDetails();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    addWorkUpdate() async {
      final int? id = ref.watch(overViewId);
      final int? siteIncharge = ref.watch(inChargeId);
      final String? token = ref.watch(newToken);
      selectedItems = [];

      if (_selectedItems.length < 1) {
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          widget: Text(
            "Please choose one or more Participant",
            style: GoogleFonts.ptSans(
              color: GlobalColors.black,
              fontSize: width < 700 ? width / 35 : width / 44,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),
          autoCloseDuration: null,
        );
      }
      if (_category == "Choose") {
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          widget: Text(
            "Please Choose One Taskcategory",
            style: GoogleFonts.ptSans(
              color: GlobalColors.black,
              fontSize: width < 700 ? width / 35 : width / 44,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),
          autoCloseDuration: null,
        );
      }
      for (var i = 0; i < selectedCheckBox.length; i++) {
        double totalQty = double.parse(
            workItemObject[selectedCheckBoxVlue[i]]["quantity"].toString());
        if (totalQty < 1) {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            widget: Text(
              "The product ( ${workItemObject[selectedCheckBoxVlue[i]]["product_name"]} ) quantity is ${workItemObject[selectedCheckBoxVlue[i]]["quantity"]}. ",
              style: GoogleFonts.ptSans(
                color: GlobalColors.black,
                fontSize: width < 700 ? width / 35 : width / 44,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
            autoCloseDuration: null,
          );
        }
        if (_controllers[selectedCheckBox[i]].text.isEmpty) {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            widget: Text(
              "Please enter some quantity for  ( ${workItemObject[selectedCheckBoxVlue[i]]["product_name"]} ) .",
              style: GoogleFonts.ptSans(
                color: GlobalColors.black,
                fontSize: width < 700 ? width / 35 : width / 44,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
            autoCloseDuration: null,
          );
        }

        double usedQty = double.parse(_controllers[selectedCheckBox[i]].text);

        if (usedQty > totalQty) {
          return QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            widget: Text(
              "The available product ( ${workItemObject[selectedCheckBoxVlue[i]]["product_name"]} ) quantity is ${workItemObject[selectedCheckBoxVlue[i]]["quantity"]}, so you cad add ${workItemObject[selectedCheckBoxVlue[i]]["quantity"]} or add less than ${workItemObject[selectedCheckBoxVlue[i]]["quantity"]} ",
              style: GoogleFonts.ptSans(
                color: GlobalColors.black,
                fontSize: width < 700 ? width / 35 : width / 44,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
            autoCloseDuration: null,
          );
        }

        selectedItems.add({
          "product_id": workItemObject[selectedCheckBoxVlue[i]]["product_id"],
          "unit_id": workItemObject[selectedCheckBoxVlue[i]]["unit_id"],
          "quantity": _controllers[selectedCheckBox[i]].text.toString(),
          "enable_serial_no": workItemObject[selectedCheckBoxVlue[i]]
              ["enable_serial_no"],
        });
      }

      if (selectedItems.isEmpty) {
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          widget: Text(
            "Please add one or more products",
            style: GoogleFonts.ptSans(
              color: GlobalColors.black,
              fontSize: width < 700 ? width / 35 : width / 44,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),
          autoCloseDuration: null,
        );
      }
      _selectedUser = [];

      _selectedItems.map((e) {
        Map<String, dynamic> newParticipant =
            participantObj.firstWhere((element) => element["name"] == e);
        _selectedUser.add(newParticipant["userid"]);
      }).toList();

      Map<String, dynamic> newCategory =
          categoryObj.firstWhere((element) => element["name"] == _category);

      Api()
          .addWorkUpdate(
              token,
              id,
              newCategory["id"],
              DateFormat("dd-MM-yyyy").format(_selectedDate),
              _selectedUser,
              _note.text,
              siteIncharge,
              selectedItems,
              serialItemList)
          .then((value) {
        Map<String, dynamic> data = jsonDecode(value);

        if (data["success"]) {
          _selectedItems = [];
          selectedCheckBox = [];
          selectedCheckBoxVlue = [];
          serialList = [];
          serialItemList = [];
          Navigator.pop(context);
          return ref.refresh(workUpdateProvider);
        } else {
          _selectedItems = [];
          selectedCheckBox = [];
          selectedCheckBoxVlue = [];
          serialList = [];
          serialItemList = [];
          Navigator.pop(context);
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: "${data["message"]}",
              autoCloseDuration: null);
        }
      });
    }

    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(right: 4, top: 20, left: 8),
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
                  Container(
                    width: width * 0.6,
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      child: Text("Choose Particiapnt"),
                      onPressed: (() => _dialogBuilder(context)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedItems.length > 0)
              Wrap(
                children: _selectedItems
                    .map((e) => Chip(
                          onDeleted: (() {
                            _selectedItems.remove(e);

                            setState(() {
                              _selectedItems = _selectedItems;
                            });
                          }),
                          label: Text(
                            "$e",
                            style: GoogleFonts.ptSans(
                              color: GlobalColors.black,
                              fontSize: width < 700 ? width / 35 : width / 44,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0,
                            ),
                          ),
                        ))
                    .toList(),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: selectedCheckBoxVlue
                                    .contains(workItemKey[i]),
                                onChanged: (bool? value) async {
                                  setState(() {
                                    // selectedCheckBox.add(workItemKey[i]);

                                    if (selectedCheckBoxVlue
                                            .contains(workItemKey[i]) ==
                                        false) {
                                      selectedCheckBox.add(i);
                                      selectedCheckBoxVlue.add(workItemKey[i]);
                                    } else {
                                      selectedCheckBoxVlue
                                          .remove(workItemKey[i]);
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 44,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 44,
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
                                    fontSize:
                                        width < 700 ? width / 35 : width / 44,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.15,
                                height: height * 0.032,
                                child: TextField(
                                  onChanged: (text) {
                                    if (text.isEmpty) {
                                      serialList.removeWhere(
                                          (element) => element["id"] == i);
                                    } else {
                                      setState(() {
                                        if (serialList.isEmpty) {
                                          serialList.add({
                                            "id": i,
                                            "productId": workItemObject[
                                                    selectedCheckBoxVlue[i]]
                                                ["product_id"],
                                            "value": int.parse(text)
                                          });
                                        } else {
                                          bool isContain = serialList.any(
                                              (element) => element["id"] == i);
                                          if (isContain) {
                                            serialList.removeWhere((element) =>
                                                element["id"] == i);
                                            serialList.add({
                                              "id": i,
                                              "productId": workItemObject[
                                                      selectedCheckBoxVlue[i]]
                                                  ["product_id"],
                                              "value": int.parse(text)
                                            });
                                          } else {
                                            serialList.add({
                                              "id": i,
                                              "productId": workItemObject[
                                                      selectedCheckBoxVlue[i]]
                                                  ["product_id"],
                                              "value": int.parse(text)
                                            });
                                          }
                                        }
                                        print("id1$serialList");
                                      });
                                    }
                                  },
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
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (workItemObject[workItemKey[i]]
                                  ["enable_serial_no"] ==
                              1)
                            if (serialList.isNotEmpty)
                              for (var j = 0; j < serialList.length; j++)
                                if (serialList[j]["id"] == i)
                                  for (var k = 0;
                                      k < serialList[j]["value"];
                                      k++)
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: TextField(
                                        onChanged: ((text) {
                                          print("id3$text");
                                          if (text.isEmpty) {
                                            serialItemList.removeWhere((element) =>
                                                element["serial_no"] == k &&
                                                element["productId"] ==
                                                    workItemObject[
                                                        selectedCheckBoxVlue[
                                                            i]]["product_id"]);
                                          } else {
                                            if (serialItemList.isEmpty) {
                                              serialItemList.add({
                                                "id": i,
                                                "serial_no": k,
                                                "productId": workItemObject[
                                                        selectedCheckBoxVlue[i]]
                                                    ["product_id"],
                                                "value": text
                                              });
                                            } else {
                                              bool isContain = serialItemList
                                                  .any((element) =>
                                                      element["serial_no"] ==
                                                          k &&
                                                      element["productId"] ==
                                                          workItemObject[
                                                                  selectedCheckBoxVlue[
                                                                      i]]
                                                              ["product_id"]);

                                              if (isContain) {
                                                serialItemList.removeWhere(
                                                    (element) =>
                                                        element["serial_no"] ==
                                                            k &&
                                                        element["productId"] ==
                                                            workItemObject[
                                                                    selectedCheckBoxVlue[
                                                                        i]]
                                                                ["product_id"]);
                                                setState(() {
                                                  serialItemList.add({
                                                    "id": i,
                                                    "serial_no": k,
                                                    "productId": workItemObject[
                                                        selectedCheckBoxVlue[
                                                            i]]["product_id"],
                                                    "value": text
                                                  });
                                                });
                                              } else {
                                                setState(() {
                                                  serialItemList.add({
                                                    "id": i,
                                                    "serial_no": k,
                                                    "productId": workItemObject[
                                                        selectedCheckBoxVlue[
                                                            i]]["product_id"],
                                                    "value": text
                                                  });
                                                });
                                              }
                                            }
                                          }

                                          print("id3$serialItemList");
                                        }),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Enter Serial No ${k}',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalColors.themeColor2),
                    onPressed: () {
                      _selectedItems = [];
                      selectedCheckBox = [];
                      selectedCheckBoxVlue = [];
                      serialList = [];
                      serialItemList = [];
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

class MultiSelect extends StatefulWidget {
  final List<String> tems;
  final Function onclick;

  const MultiSelect({Key? key, required this.tems, required this.onclick})
      : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  _itemChange(String item, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(item);
      } else {
        _selectedItems.remove(item);
      }
    });
    widget.onclick(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Participants'),
      content: SingleChildScrollView(
        child: ListBody(
          children: participants
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    onChanged: (isChecked) {
                      _itemChange(item, isChecked!);
                    },
                  ))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            _selectedItems = [];
            selectedCheckBox = [];
            selectedCheckBoxVlue = [];

            widget.onclick(_selectedItems);
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Ok'),
          onPressed: () {
            setState(() {
              _selectedItems = _selectedItems;
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

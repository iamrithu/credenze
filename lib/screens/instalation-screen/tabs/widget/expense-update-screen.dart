import 'dart:io';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../apis/api.dart';
import '../../../../models/expenses-model.dart';
import '../../../lead-screen/tabs/widgets/lead_custom_input.dart';
import '../../../lead-screen/tabs/widgets/lead_custom_lable.dart';

List<String> fromPlaceList = [
  "Office",
  "Home",
];

class ExpenseUpdateAddScreen extends ConsumerStatefulWidget {
  final Function onclick;
  final ExpensesModel data;
  ExpenseUpdateAddScreen({
    Key? key,
    required this.onclick,
    required this.data,
  }) : super(key: key);

  @override
  _ExpenseUpdateAddScreenState createState() => _ExpenseUpdateAddScreenState();
}

class _ExpenseUpdateAddScreenState
    extends ConsumerState<ExpenseUpdateAddScreen> {
  List<dynamic> categoryList = [];
  Map<String, dynamic> location = {};
  String category = "--";
  String fromPlace = "";
  String toPlace = "";
  int categoryId = 0;

  DateTime _selectedDate = DateTime.now();
  late TextEditingController _amount = TextEditingController();

  late TextEditingController _note = TextEditingController();
  late TextEditingController _distance = TextEditingController();

  File? newFile = null;

  getCategory() {
    Api()
        .expansesCategory(ref.read(newToken), ref.read(overViewId))
        .then((value) {
      setState(() {
        categoryList = value.data["data"];
      });
      print(categoryList.toString());
    });
  }

  getLocation(DateTime date) {
    Api()
        .expansesLocation(ref.read(newToken), ref.read(overViewId),
            DateFormat("dd-MM-yyyy").format(date).toString())
        .then((value) {
      setState(() {
        location = value.data["data"];
      });
      setState(() {
        fromPlace = location["from_place"];
        toPlace = location["to_place"];
      });
      print(location.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.data.toJson());

    setState(() {
      _amount.text = widget.data.amount!;
      _selectedDate = widget.data.expensesDate!;
      fromPlace = widget.data.fromPlace ?? "";
      toPlace = widget.data.toPlace ?? "";
      category = widget.data.category!.name!;
      categoryId = widget.data.categoryId!;
      _distance.text =
          widget.data.distance == null ? "" : widget.data.distance.toString();
    });

    getCategory();
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
              height: height * 0.06,
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      height: height * 0.05,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date",
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
                      showDatePicker(
                        context: context,
                        currentDate: DateTime.now(),
                        initialDate: _selectedDate,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        getLocation(value!);
                        setState(() {
                          _selectedDate = value;
                        });
                      });
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
              margin: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  Container(
                      width: width * 0.308,
                      height: height * 0.05,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Category",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.black,
                          fontSize: width < 700 ? width / 35 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      )),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getLocation(_selectedDate);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                content: Container(
                                  width: width,
                                  height: height * 0.2,
                                  child: Column(children: [
                                    for (var i = 0;
                                        i < categoryList.length;
                                        i++)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            category = categoryList[i]["name"];
                                            categoryId = categoryList[i]["id"];
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 12),
                                            child: Center(
                                                child: Text(
                                                    "${categoryList[i]["name"]}",
                                                    style: GoogleFonts.ptSans(
                                                        fontSize: width < 700
                                                            ? width / 35
                                                            : width / 40,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: GlobalColors
                                                            .themeColor,
                                                        letterSpacing: 0))),
                                          ),
                                        ),
                                      )
                                  ]),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: height * 0.06,
                        margin: EdgeInsets.only(left: 5, right: 2),
                        padding: EdgeInsets.only(left: width * 0.07),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(color: GlobalColors.themeColor2)),
                        child: Text(
                          "${category}",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 35 : width / 40,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.black,
                              letterSpacing: 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (categoryId != 1)
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
            if (categoryId == 1)
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
                          "From",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.black,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        )),
                    Expanded(
                      child: InkWell(
                        onTap: location["from_place"] != "HOME_OFFICE"
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: AlertDialog(
                                        content: Container(
                                          width: width,
                                          height: height * 0.3,
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "From Place",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 30
                                                          : width / 40,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      letterSpacing: 0),
                                                ),
                                              ],
                                            ),
                                            for (var i = 0;
                                                i < fromPlaceList.length;
                                                i++)
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    fromPlace =
                                                        fromPlaceList[i];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                  elevation: 5,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 12),
                                                    child: Center(
                                                        child: Text(
                                                            "${fromPlaceList[i]}",
                                                            style: GoogleFonts.ptSans(
                                                                fontSize: width <
                                                                        700
                                                                    ? width / 35
                                                                    : width /
                                                                        40,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                letterSpacing:
                                                                    0))),
                                                  ),
                                                ),
                                              ),
                                            Text(
                                              "(OR)",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 40,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor,
                                                  letterSpacing: 0),
                                            ),
                                            Container(
                                              width: width * 0.65,
                                              margin: EdgeInsets.only(top: 10),
                                              alignment:
                                                  AlignmentDirectional.center,
                                              padding: EdgeInsets.only(
                                                  left: width * 0.08),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                    color: GlobalColors
                                                        .themeColor2),
                                              ),
                                              child: TextFormField(
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 700
                                                        ? width / 30
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                                decoration: InputDecoration(
                                                  hintText: "Enter place",
                                                  hintStyle: GoogleFonts.ptSans(
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      fontSize: width < 700
                                                          ? width / 35
                                                          : width / 45,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 0),
                                                  border: InputBorder.none,
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    fromPlace =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                        child: Container(
                          height: height * 0.06,
                          margin: EdgeInsets.only(left: 5, right: 2),
                          padding: EdgeInsets.only(left: width * 0.07),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: GlobalColors.themeColor2)),
                          child: Text(
                            "${fromPlace == "HOME_OFFICE" ? "--" : fromPlace}",
                            style: GoogleFonts.ptSans(
                                fontSize: width < 700 ? width / 35 : width / 40,
                                fontWeight: FontWeight.w400,
                                color: GlobalColors.black,
                                letterSpacing: 0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (categoryId == 1)
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
                          "To",
                          style: GoogleFonts.ptSans(
                            color: GlobalColors.black,
                            fontSize: width < 700 ? width / 35 : width / 44,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        )),
                    Expanded(
                      child: Container(
                        height: height * 0.06,
                        margin: EdgeInsets.only(left: 5, right: 2),
                        padding: EdgeInsets.only(left: width * 0.07),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                                Border.all(color: GlobalColors.themeColor2)),
                        child: Text(
                          "${toPlace}",
                          style: GoogleFonts.ptSans(
                              fontSize: width < 700 ? width / 35 : width / 40,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.black,
                              letterSpacing: 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (categoryId == 1)
              Container(
                width: width,
                height: height * 0.057,
                margin: EdgeInsets.only(bottom: height * 0.01),
                child: Row(
                  children: [
                    LeadCustomlabel(
                      label: "KM",
                      start: "*",
                    ),
                    LeadCustomInput(
                      label: "Eg:12",
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
                      padding: EdgeInsets.only(left: width * 0.07),
                      alignment: Alignment.centerLeft,
                      child: newFile == null
                          ? Text(
                              "Choose File ",
                              style: GoogleFonts.ptSans(
                                color: GlobalColors.themeColor2,
                                fontSize: width < 700 ? width / 35 : width / 44,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
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
            SizedBox(
              height: 6,
            ),
            Container(
              width: width,
              height: height * 0.057,
              margin: EdgeInsets.only(bottom: height * 0.01),
              child: Row(
                children: [
                  LeadCustomlabel(
                    label: "Notes",
                    start: "*",
                  ),
                  LeadCustomInput(
                    label: "--",
                    controller: _note,
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.white,
                          fontSize: width < 700 ? width / 35 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (categoryId == 0) {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: "Choose Category",
                              autoCloseDuration: null);
                          return null;
                        }
                        if (categoryId > 1) {
                          if (_amount.text.trim().isEmpty) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: "Enter Amount",
                                autoCloseDuration: null);
                            return null;
                          }
                        }
                        if (categoryId == 1) {
                          if (fromPlace == "HOME_OFFICE") {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: "Choose From Place",
                                autoCloseDuration: null);
                            return null;
                          }
                          if (_distance.text.trim().isEmpty) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: "Enter distance in KM",
                                autoCloseDuration: null);
                            return null;
                          }
                        }
                        print("1oo rithi");
                        Map<String, dynamic> data = {
                          "installation_id": ref.read(overViewId),
                          "user_id": ref.read(userId),
                          "expenses_date": DateFormat("dd-MM-yyyy")
                              .format(_selectedDate)
                              .toString(),
                          "category_id": categoryId,
                          "from_place": categoryId == 1 ? fromPlace : "",
                          "to_place": categoryId == 1 ? toPlace : "",
                          "distance": categoryId == 1 ? _distance.text : "",
                          "amount": categoryId == 1 ? "" : _amount.text,
                          "attachment": newFile,
                          "status": "pending"
                        };

                        Api()
                            .updateExpense(
                                expenseId: widget.data.id!,
                                data: data,
                                token: ref.watch(newToken),
                                id: ref.watch(overViewId))
                            .then((value) {
                          widget.onclick();
                          Navigator.pop(context);
                        });
                        // print(data.toString());
                      },
                      child: Text(
                        "Add",
                        style: GoogleFonts.ptSans(
                          color: GlobalColors.white,
                          fontSize: width < 700 ? width / 35 : width / 44,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ));
  }
}

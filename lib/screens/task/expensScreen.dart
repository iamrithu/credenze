import 'dart:io';

import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../const/global_colors.dart';

class MainExpenseScreen extends ConsumerStatefulWidget {
  final bool isCompleted;
  const MainExpenseScreen({Key? key, required this.isCompleted})
      : super(key: key);

  @override
  _MainExpenseScreenState createState() => _MainExpenseScreenState();
}

class _MainExpenseScreenState extends ConsumerState<MainExpenseScreen> {
  File? newFile = null;
  String cat = "Petrol";
  String amt = "";
  String note = "";
  String distance = "";
  List<dynamic> getExpenses = [];

  bool chooseCat = false;
  bool openForm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api()
        .publickGetExpense(ref.read(newToken)!, ref.read(publicTaskId))
        .then((value) {
      setState(() {
        getExpenses = value;
      });
    });
  }

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
                          if (getExpenses.isEmpty)
                            Center(
                              child: Text(
                                "Expense not found!",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor,
                                    fontSize:
                                        width < 700 ? width / 30 : width / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ),
                          if (getExpenses.isNotEmpty)
                            for (var i = 0; i < getExpenses.length; i++)
                              Card(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  constraints: BoxConstraints(
                                      minHeight: height * 0.06,
                                      minWidth: width),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: width * 0.15,
                                          height: height * 0.06,
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              getExpenses[i]["user"]
                                                  ["image_url"],
                                            ),
                                          )),
                                      Container(
                                        width: width * 0.4,
                                        height: height * 0.06,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${getExpenses[i]["user"]["name"]}",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                            Text(
                                              "${getExpenses[i]["category_id"] == 1 ? "Petrol" : "Food"}",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  fontSize: width < 700
                                                      ? width / 35
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  "${getExpenses[i]["notes"] ?? "--"}",
                                                  style: GoogleFonts.ptSans(
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      fontSize: width < 700
                                                          ? width / 35
                                                          : width / 55,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            width: width * 0.15,
                                            height: height * 0.06,
                                            child: Center(
                                              child: Text(
                                                getExpenses[i]["category_id"]==1?double.parse(getExpenses[i]["amount"]).toInt().toString()+"\n(${double.parse(getExpenses[i]["expense_km"])}km)":
                                                double.parse(getExpenses[i]["amount"]).toInt().toString(),
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.themeColor2,
                                                    fontSize: width < 700
                                                        ? width / 35
                                                        : width / 45,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0),
                                              ),
                                            ),
                                          ),
                                           
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Api()
                                              .removeExpense(
                                                  ref.watch(newToken)!,
                                                  ref.watch(publicTaskId),
                                                  getExpenses[i]["id"])
                                              .then((value) {
                                            if (value.data["success"]) {
                                              Api()
                                                  .publickGetExpense(
                                                      ref.read(newToken)!,
                                                      ref.read(publicTaskId))
                                                  .then((value) {
                                                setState(() {
                                                  getExpenses = value;
                                                });
                                              });
                                            } else {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.info,
                                                onConfirmBtnTap:(){

                                                },
                                                widget: Text(
                                                  "${value.data["message"]}",
                                                  style: GoogleFonts.ptSans(
                                                      fontSize: width < 700
                                                          ? width / 30
                                                          : width / 48,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      letterSpacing: 0),
                                                ),
                                                autoCloseDuration:
                                                    Duration(seconds: 1),
                                              );
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.1,
                                          height: height * 0.06,
                                          child: Center(
                                            child: Icon(
                                              Icons.delete,
                                              size: width / 30,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.isCompleted)
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
              elevation: 1,
              margin: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                width: width,
                height: height * 0.5,
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.7,
                      padding: const EdgeInsets.all(4.0),
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
                            height: height * 0.04,
                            child: Row(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.25,
                                child: Text(
                                  "Category*",
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
                                width: width * 0.06,
                                child: Text(":"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    chooseCat = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: GlobalColors.themeColor2)
                                  ),
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
                            ]),
                          ),
                          if (cat == "Food")
                            Container(
                              width: width,
                              height: height * 0.06,
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: width * 0.25,
                                  child: Text(
                                    "Amount*",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 48,
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
                                Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    child: TextFormField(
                                    
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          amt = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          if (cat == "Petrol")
                            Container(
                              width: width,
                              height: height * 0.06,
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: width * 0.25,
                                  child: Text(
                                    "Distance*",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 48,
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
                                Card(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          distance = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: Row(
                              children: [
                                Container(
                                    width: width * 0.24,
                                    height: height * 0.05,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: width * 0.01),
                                    child: Text(
                                      "File ",
                                      style: GoogleFonts.ptSans(
                                        color: GlobalColors.black,
                                        fontSize: width < 700
                                            ? width / 35
                                            : width / 44,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0,
                                      ),
                                    )),
                                    Container(
                                  alignment: Alignment.centerLeft,
                                  width: width * 0.05,
                                  child: Text(":"),
                                ),
                                Container(
                                  width: width * 0.39,
                                  height: height * 0.05,
                                  margin: EdgeInsets.only(left: 5, right: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: GlobalColors.themeColor2)),
                                  child: Container(
                                    width: width * 0.19,
                                    padding:
                                        EdgeInsets.only(left: width * 0.07),
                                    alignment: Alignment.centerLeft,
                                    child: newFile == null
                                        ? Text(
                                            "Choose File ",
                                            style: GoogleFonts.ptSans(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 40
                                                  : width / 44,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0,
                                            ),
                                          )
                                        : Text(
                                            newFile == null
                                                ? "Choose File "
                                                : "${newFile!.path.split('/').last}",
                                            style: GoogleFonts.ptSans(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 40
                                                  : width / 44,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(allowMultiple: true);
                                    if (result != null) {
                                      File file =
                                          File(result.files.single.path!);
                                      setState(() {
                                        newFile = file;
                                      });
                                    }
                                  },
                                  child: Container(
                                      width: width * 0.1,
                                      height: height * 0.05,
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: GlobalColors.themeColor2),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Center(
                                        child: Icon(FontAwesomeIcons.file,
                                            color: GlobalColors.themeColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width,
                            height: height * 0.06,
                            child: Row(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: width * 0.25,
                                child: Text(
                                  "Notes",
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
                              Card(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: width * 0.5,
                                  height: height * 0.05,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        note = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: width,
                            height: height * 0.04,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      openForm = false;
                                    });
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if(distance.trim().isEmpty){
print("rithi");
                                      }
                                      Map<String, dynamic> data = {
                                        "category_id": cat == "Petrol" ? 1 : 2,
                                        "expense_km":
                                            cat == "Petrol" ? distance : "",
                                        "notes": note,
                                        "amount": cat == "Petrol" ? "0" : amt,
                                        "attachment": newFile
                                      };

                                      Api()
                                          .publicExpenseAdd(
                                              ref.watch(newToken)!,
                                              ref.watch(publicTaskId),
                                              data)
                                          .then((value) {
                                        print(value.statusCode.toString());

                                        if (value.statusCode == 422) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.info,
                                            title: "${value.data["error"]["message"]}" ,
                                           onConfirmBtnTap: (){},
                                            autoCloseDuration:
                                                Duration(seconds: 1),
                                          );

                                          
                                        }else{
  if (value.data["success"]) {
                                          Api()
                                              .publickGetExpense(
                                                  ref.read(newToken)!,
                                                  ref.read(publicTaskId))
                                              .then((value) {
                                            setState(() {
                                              getExpenses = value;
                                            });
                                          });
                                          setState(() {
                                            openForm = false;
                                            amt = "";
                                            distance = "";
                                          });

                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.info,
                                            widget: Text(
                                              "${value.data["message"]}",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
                                                                                       onConfirmBtnTap: (){},

                                            autoCloseDuration:
                                                Duration(seconds: 1),
                                          );
                                        } else {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.info,
                                            widget: Text(
                                              "${value.data["message"]}",
                                              style: GoogleFonts.ptSans(
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 48,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
                                                                                       onConfirmBtnTap: (){},

                                            autoCloseDuration:
                                                Duration(seconds: 2),
                                          );
                                          setState(() {
                                            openForm = false;
                                            amt = "";
                                            distance = "";
                                          });
                                        }
                                        }
                                      
                                      });
                                    },
                                    child: Text("Save")),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Container(
                      width: width,
                      color: Colors.white,
                      height: height * 0.2,
                      padding: EdgeInsets.all(20),
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
                              elevation: 10,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: width,
                                height: height * 0.05,
                                child: Center(
                                  child: Text(
                                    "Petrol",
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
                          InkWell(
                            onTap: () {
                              setState(() {
                                cat = "Food";
                                chooseCat = false;
                              });
                            },
                            child: Card(
                              elevation: 10,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: width,
                                height: height * 0.05,
                                child: Center(
                                  child: Text(
                                    "Food",
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

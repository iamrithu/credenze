import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../instalation-screen/tabs/widget/text-row-widget.dart';

class OverAllExpense extends ConsumerStatefulWidget {
  const OverAllExpense({Key? key}) : super(key: key);

  @override
  _OverAllExpenseState createState() => _OverAllExpenseState();
}

class _OverAllExpenseState extends ConsumerState<OverAllExpense> {
  List<Map<String, dynamic>> expensesList = [];
  List<Map<String, dynamic>> allExpenseList = [];
  bool isFillterEnable = false;
  DateTime selectedDate = DateTime.now();

  getAllExpenses() {
    setState(() {
      allExpenseList = [];
    });
    Api().getAllExpense(ref.read(newToken)!).then((value) {
      value.data["data"].forEach((key, value) {
        setState(() {
          value["id"] = key;

          allExpenseList.add(value);
        });
      });
      setState(() {
        expensesList = allExpenseList;
      });
    });
  }

  onSelectedDates(context, value) {
    setState(() {
      selectedDate = value;
      expensesList = [];
    });

    for (var i = 0; i < allExpenseList.length; i++) {
      if ("${DateFormat("dd-MM-yyyy").format(DateTime.parse(allExpenseList[i]["expense_date"]))}" ==
          "${DateFormat("dd-MM-yyyy").format(selectedDate)}") {
        expensesList.add(allExpenseList[i]);
      }
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: width < 700 ? height * 0.8 : height * 0.9,
      child: Column(
        children: [
          Container(
            width: width,
            height: height * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${DateFormat("dd-MM-yyyy").format(selectedDate)}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                        color: GlobalColors.themeColor2,
                        fontSize: width < 700 ? width / 34 : width / 45,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0),
                  ),
                  Row(
                    children: [
                      if (isFillterEnable)
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                expensesList = allExpenseList;
                                setState(() {
                                  isFillterEnable = false;
                                });
                              });
                            },
                            child: Text("Refresh")),
                      SizedBox(
                        width: 10,
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
                                  initialSelectedDate: selectedDate,
                                  view: DateRangePickerView.month,
                                  toggleDaySelection: true,
                                  navigationDirection:
                                      DateRangePickerNavigationDirection
                                          .vertical,
                                  selectionShape:
                                      DateRangePickerSelectionShape.rectangle,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,

                                  monthViewSettings:
                                      DateRangePickerMonthViewSettings(
                                          firstDayOfWeek: 7),
                                  // onSelectionChanged: onSelectedDates,
                                  showActionButtons: true,

                                  onSubmit: (value) {
                                    // getAllExpenses();
                                    if (value == null) {
                                                                          Navigator.pop(context);

                                    } else {
                                      setState(() {
                                        isFillterEnable = true;
                                      });
                                      onSelectedDates(context, value);
                                    }
                                  },
                                  onCancel: () {
                                    setState(() {
                                      expensesList = allExpenseList;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          );
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
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return Future<void>.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    selectedDate = DateTime.now();
                  });
                  return getAllExpenses();
                });
              },
              child: ListView(
                children: [
                  if (expensesList.isEmpty)
                    Center(
                      child: Text(
                        "Not Available",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                            color: GlobalColors.themeColor2,
                            fontSize: width < 700 ? width / 34 : width / 45,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0),
                      ),
                    ),
                  for (var i = 0; i < expensesList.length; i++)
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: GlobalColors.themeColor2),
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        width: width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width * 0.9,
                                  child: Column(
                                    children: [
                                      TextRowWidget(
                                        width: width,
                                        lable: "Section",
                                        value: "${expensesList[i]["section"]}",
                                      ),
                                      TextRowWidget(
                                        width: width,
                                        lable: "Date",
                                        value:
                                            "${DateFormat("dd-MM-yyyy").format(DateTime.parse(expensesList[i]["expense_date"]))}",
                                      ),
                                      TextRowWidget(
                                        width: width,
                                        lable: "Category",
                                        value: "${expensesList[i]["category"]}",
                                      ),
                                      if (expensesList[i]["category"] ==
                                          "Petrol")
                                        TextRowWidget(
                                          width: width,
                                          lable: "From Place",
                                          value:
                                              "${expensesList[i]["from_place"]}",
                                        ),
                                      if (expensesList[i]["category"] ==
                                          "Petrol")
                                        TextRowWidget(
                                          width: width,
                                          lable: "To Place",
                                          value:
                                              "${expensesList[i]["to_place"]}",
                                        ),
                                      TextRowWidget(
                                        width: width,
                                        lable: "Amount",
                                        value:
                                            "${double.parse(expensesList[i]["amount"]).toInt()}",
                                      ),
                                      TextRowWidget(
                                        width: width,
                                        lable: "Status",
                                        value: expensesList[i]["status"][0]
                                                .toUpperCase() +
                                            expensesList[i]["status"]
                                                .substring(1),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

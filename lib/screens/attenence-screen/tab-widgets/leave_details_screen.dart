import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/attenence-screen/widgets/custom-attendence-scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../apis/notification_api.dart';
import '../../../const/global_colors.dart';
import '../../../models/leaveListModel.dart';
import '../../instalation-screen/tabs/widget/text-row-widget.dart';
import '../widgets/leave_apply_screen.dart';

class LeaveDetailsScreen extends ConsumerStatefulWidget {
  const LeaveDetailsScreen({Key? key}) : super(key: key);

  @override
  _LeaveDetailsScreenState createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends ConsumerState<LeaveDetailsScreen> {
  DateTime newDate = DateTime.now();
  List<LeaveListModel> filteredData = [];
  String status = "";
  bool allData = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(leaveListModelProvider);

    getDetails(List<LeaveListModel> filteredData) {
      List<int> data = [];

      for (var i = 0; i < filteredData.length; i++) {
        if (DateFormat("MM").format(newDate) ==
            DateFormat("MM").format(filteredData[i].date)) {
          data.add(filteredData[i].id);
        }
      }

      return data.isEmpty ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Data not found"),
        ],
      ) : Text("");
    }

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return LeaveApplyScreen();
            },
          );
        },
        icon: Icon(
          Icons.add,
          color: GlobalColors.white,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.themeColor,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        label: Text(
          "Add Leave",
          style: GoogleFonts.ptSans(
              color: GlobalColors.white,
              fontSize: width < 700 ? width / 35 : width / 45,
              fontWeight: FontWeight.w400,
              letterSpacing: 0),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            width: width,
            height: width < 500 ? height * 0.05 : height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: DateFormat("MMMM").format(newDate),
                      style: GoogleFonts.ptSans(
                          fontSize: width < 700 ? width / 16 : width / 22,
                          fontWeight: FontWeight.w400,
                          color: GlobalColors.themeColor2,
                          letterSpacing: 2),
                      children: [
                        TextSpan(
                          text: " - " + newDate.year.toString(),
                          style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 22 : width / 45,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.black,
                            letterSpacing: 2,
                          ),
                        ),
                      ]),
                ),
                if (!allData)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          newDate=DateTime.now();
                          allData = true;
                        });
                      },
                      child: Text("refresh")),
                GestureDetector(
                  onTap: () {
                    showMonthYearPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100))
                        .then((value) {
                      setState(() {
                        newDate = value!;
                        allData = false;
                      });
                    });
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
          ),
          Container(
              width: width,
              height: width < 500 ? height * 0.633 : height * 0.66,
              child: LayoutBuilder(builder: (context, constraints) {
                return data.when(
                    data: (_data) {
                      return RefreshIndicator(
                        color: Colors.white,
                        backgroundColor: GlobalColors.themeColor,
                        strokeWidth: 4.0,
                        onRefresh: () async {
                          return Future<void>.delayed(
                              const Duration(seconds: 2), () {
                            return ref.refresh(leaveListModelProvider);
                          });
                        },
                        child: ListView(
                          children: [
                            if (_data.isEmpty)
                              Center(
                                child: Text(
                                  "Not Available",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.themeColor2,
                                      fontSize:
                                          width < 700 ? width / 34 : width / 45,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                                ),
                              ),
                            getDetails(_data),
                            if (allData)
                              for (var i = 0; i < _data.length; i++)
                                Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: GlobalColors.themeColor2),
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Container(
                                    width: width,
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width * 0.9,
                                              child: Column(
                                                children: [
                                                  TextRowWidget(
                                                    width: width,
                                                    lable: "Leave Type",
                                                    value: _data[i]
                                                                .leaveTypeId ==
                                                            1
                                                        ? "Casual"
                                                        : _data[i].leaveTypeId ==
                                                                2
                                                            ? "Sick"
                                                            : "Earned",
                                                  ),
                                                  TextRowWidget(
                                                    width: width,
                                                    lable: "Leave Duration ",
                                                    value: _data[i].duration +
                                                        " ( ${_data[i].halfDayType == null ? "Full Day" : _data[i].halfDayType == "first_half" ? "Forenoon" : "Afternoon"} )",
                                                  ),
                                                  TextRowWidget(
                                                    width: width,
                                                    lable: "Leave Date",
                                                    value:
                                                        "${DateFormat("dd-MM-yyyy").format(_data[i].date)}",
                                                  ),
                                                  TextRowWidget(
                                                    width: width,
                                                    lable: "Reason",
                                                    value: "${_data[i].reason}",
                                                  ),
                                                  TextRowWidget(
                                                    width: width,
                                                    lable: "Leave Status",
                                                    value: _data[i]
                                                            .status[0]
                                                            .toUpperCase() +
                                                        _data[i]
                                                            .status
                                                            .substring(1),
                                                  ),
                                                  if (_data[i].status ==
                                                      "rejected")
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Rejected Reason",
                                                      value:
                                                          "${_data[i].rejectReason}",
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
                            if (allData == false)
                              for (var i = 0; i < _data.length; i++)
                                if (DateFormat("MM").format(newDate) ==
                                    DateFormat("MM").format(_data[i].date))
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: GlobalColors.themeColor2),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Container(
                                      width: width,
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: width * 0.9,
                                                child: Column(
                                                  children: [
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Leave Type",
                                                      value: _data[i]
                                                                  .leaveTypeId ==
                                                              1
                                                          ? "Casual"
                                                          : _data[i].leaveTypeId ==
                                                                  2
                                                              ? "Sick"
                                                              : "Earned",
                                                    ),
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Leave Duration ",
                                                      value: _data[i].duration +
                                                          " ( ${_data[i].halfDayType == null ? "Full Day" : _data[i].halfDayType == "first_half" ? "Forenoon" : "Afternoon"} )",
                                                    ),
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Leave Date",
                                                      value:
                                                          "${DateFormat("dd-MM-yyyy").format(_data[i].date)}",
                                                    ),
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Reason",
                                                      value:
                                                          "${_data[i].reason}",
                                                    ),
                                                    TextRowWidget(
                                                      width: width,
                                                      lable: "Leave Status",
                                                      value: _data[i]
                                                              .status[0]
                                                              .toUpperCase() +
                                                          _data[i]
                                                              .status
                                                              .substring(1),
                                                    ),
                                                    if (_data[i].status ==
                                                        "rejected")
                                                      TextRowWidget(
                                                        width: width,
                                                        lable:
                                                            "Rejected Reason",
                                                        value:
                                                            "${_data[i].rejectReason}",
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
                      );
                    },
                    error: (err, s) => RefreshIndicator(
                          color: Colors.white,
                          backgroundColor: GlobalColors.themeColor,
                          strokeWidth: 4.0,
                          onRefresh: () async {
                            return Future<void>.delayed(
                                const Duration(seconds: 2), () {
                              return ref.refresh(expenseProvider);
                            });
                          },
                          child: ListView(
                            children: [
                              Container(
                                width: width,
                                height: height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Not Available $err",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.themeColor2,
                                            fontSize: width < 700
                                                ? width / 34
                                                : width / 45,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ));
              })),
        ],
      ),
    );
  }
}

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
import '../../instalation-screen/tabs/widget/text-row-widget.dart';
import '../widgets/leave_apply_screen.dart';

class LeaveDetailsScreen extends ConsumerStatefulWidget {
  const LeaveDetailsScreen({Key? key}) : super(key: key);

  @override
  _LeaveDetailsScreenState createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends ConsumerState<LeaveDetailsScreen> {
  DateTime newDate = DateTime.now();
  String status="";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
        final data = ref.watch(leaveListModelProvider);



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
          color: GlobalColors.themeColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: GlobalColors.themeColor, width: 2),
              borderRadius: BorderRadius.circular(50)),
        ),
        label: Text(
          "Add Leave",
          style: GoogleFonts.ptSans(
              color: GlobalColors.themeColor,
              fontSize: width < 700 ? width / 28 : width / 45,
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
                GestureDetector(
                  onTap: ()  {
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

                              onSubmit: (value) => Navigator.pop(context)
                               ,
                              onCancel: () => Navigator.pop(context),
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
                return Future<void>.delayed(const Duration(seconds: 2), () {
                  return ref.refresh(leaveListModelProvider);
                });
              },
              child: ListView(
                children: [
if(_data.isEmpty) Center(child:Text(
                              "Not Available",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor2,
                                  fontSize: width < 700
                                      ? width/ 34
                                      :width / 45,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0),
                            ), ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:width * 0.9,
                                  child: Column(
                                    children: [
                                       TextRowWidget(
                                        width:width,
                                        lable: "Leave Type",
                                        value: _data[i].leaveTypeId==1?"Casual":_data[i].leaveTypeId==2?"Sick":"Earned",
                                      ),
                                       TextRowWidget(
                                        width:width,
                                        lable: "Leave Duration ",
                                        value: _data[i].duration + " ( ${_data[i].halfDayType==null?"Full Day":_data[i].halfDayType=="first_half"?"Forenoon":"Afternoon"} )",
                                      ),
                                      TextRowWidget(
                                        width:width,
                                        lable: "Leave  Date",
                                        value: "${DateFormat("dd-MM-yyyy").format(_data[i].date)}",
                                      ),
                                      TextRowWidget(
                                        width:width,
                                        lable: "Leave Status",
                                        value: "${_data[i].status}",
                                      ),
                                         TextRowWidget(
                                        width:width,
                                        lable: "Reason",
                                        value: "${_data[i].reason}",
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
                  return Future<void>.delayed(const Duration(seconds: 2), () {
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
                                      ? width/ 34
                                      :width / 45,
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

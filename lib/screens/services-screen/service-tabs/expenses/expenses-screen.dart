import 'dart:convert';

import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/expense-update-screen.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../const/global_colors.dart';
import 'expande-add-screen.dart';
import 'expenses-update-screen.dart';

class SeviceExpenseScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const SeviceExpenseScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<SeviceExpenseScreen> createState() =>
      _SeviceExpenseScreenState();
}

class _SeviceExpenseScreenState extends ConsumerState<SeviceExpenseScreen> {
  List<String> cat = [];
  int? selectedId = null;

  @override
  void initState() {
    super.initState();
  }

  refresh() async {
    print("dd");
    return Future<void>.delayed(const Duration(seconds: 1), () {
      return ref.refresh(serviceExpenseProvider);
    });
  }

  @override
  Widget build(BuildContext) {
    final expenseDetail = ref.watch(serviceExpenseProvider);
    final token = ref.watch(newToken);
    final id = ref.watch(overViewId);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: GlobalColors.themeColor,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    width: widget.width,
                    height: widget.height,
                    child: ServiceExpenseAddScreen(onclick: refresh),
                  ),
                );
              },
            );
          }),
      body: expenseDetail.when(
          data: (_data) {
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: GlobalColors.themeColor,
              strokeWidth: 4.0,
              onRefresh: () async {
                return Future<void>.delayed(const Duration(seconds: 2), () {
                  return ref.refresh(serviceExpenseProvider);
                });
              },
              child: ListView(
                children: [
                  _data.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "No Information Available",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.black,
                                    fontSize: widget.width! < 700
                                        ? widget.width! / 30
                                        : widget.width! / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                            ),
                          ],
                        )
                      : Text(""),
                  for (var i = 0; i < _data.length; i++)
                    Stack(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: GlobalColors.themeColor,
                          child: Container(
                            width: widget.width,
                            height: _data[i].categoryId == 1
                                ? widget.height! * 0.4
                                : widget.height! * 0.25,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  selectedId = null;
                                });
                              }),
                              onLongPress: (() {
                                setState(() {
                                  selectedId = _data[i].id!;
                                });
                              }),
                              child: Card(
                                  elevation: 0,
                                  // shape: RoundedRectangleBorder(
                                  // side: BorderSide(
                                  // color: GlobalColors.themeColor2),
                                  // borderRadius: BorderRadius.circular(4)),
                                  child: Container(
                                    width: widget.width! * 0.97,
                                    height: _data[i].categoryId == 1
                                        ? widget.height! * 0.4
                                        : widget.height! * 0.25,
                                    padding: EdgeInsets.only(
                                        left: widget.width! * 0.03),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Id",
                                          value: "#${_data[i].id!}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Expense Date",
                                          value: DateFormat("dd-MM-yyyy")
                                              .format(_data[i].expensesDate!),
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Category",
                                          value: _data[i].category!.name,
                                        ),
                                        if (_data[i].categoryId == 1)
                                          TextRowWidget(
                                            width: widget.width!,
                                            lable: "From place",
                                            value: _data[i].fromPlace,
                                          ),
                                        if (_data[i].categoryId == 1)
                                          TextRowWidget(
                                            width: widget.width!,
                                            lable: "To place",
                                            value: _data[i].toPlace,
                                          ),
                                        if (_data[i].categoryId == 1)
                                          TextRowWidget(
                                            width: widget.width!,
                                            lable: "Distance",
                                            value: "${_data[i].distance} km",
                                          ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Amount",
                                          value: "${_data[i].amount!} Rs",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Status",
                                          value: "${_data[i].status!}",
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _data[i].id == selectedId,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (() {
                                  setState(() {
                                    selectedId = null;
                                  });
                                }),
                                child: Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Color.fromARGB(208, 205, 203, 203),
                                  child: Container(
                                    width: widget.width! * 0.97,
                                    height: _data[i].categoryId == 1
                                        ? widget.height! * 0.4
                                        : widget.height! * 0.25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              setState(() {
                                                selectedId = null;
                                              });
                                            });
                                          },
                                          child: Card(
                                            shadowColor: GlobalColors.black,
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              child: Icon(
                                                Icons.cancel_sharp,
                                                color: GlobalColors.themeColor2,
                                                size: widget.width! < 700
                                                    ? widget.width! / 18
                                                    : widget.width! / 45,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: widget.width! * 0.06,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedId = null;
                                            });
                                            showModalBottomSheet<void>(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Container(
                                                    width: widget.width,
                                                    height: widget.height,
                                                    child:
                                                        ServiceExpenseUpdateScreen(
                                                      onclick: refresh,
                                                      data: _data[i],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              child: Icon(
                                                FontAwesomeIcons.penToSquare,
                                                color: GlobalColors.themeColor,
                                                size: widget.width! < 700
                                                    ? widget.width! / 20
                                                    : widget.width! / 45,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: widget.width! * 0.06,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                    return ref.refresh(serviceExpenseProvider);
                  });
                },
                child: ListView(
                  children: [
                    Container(
                      width: widget.width,
                      height: widget.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Not Available",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor2,
                                  fontSize: widget.width! < 700
                                      ? widget.width! / 34
                                      : widget.width! / 45,
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
              )),
    );
  }
}

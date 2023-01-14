import 'dart:convert';

import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import '../../../const/global_colors.dart';
import '../../../models/expense-category-model.dart';
import 'widget/add-expense-screen.dart';

class ExpenseScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const ExpenseScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends ConsumerState<ExpenseScreen> {
  List<String> cat = [];
  int? selectedId = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final expenseDetail = ref.watch(expenseProvider);
    final token = ref.watch(newToken);
    final id = ref.watch(overViewId);
    return Scaffold(
      floatingActionButton: Consumer(builder: ((context, ref, child) {
        final data = ref.watch(expenseCategoryProvider);
        return data.when(
            data: ((_data) {
              cat = [];
              for (var i = 0; i < _data.length; i++) {
                cat.add(_data[i].name!);
              }
              return ElevatedButton.icon(
                onPressed: () {
                  Api().ExpensePlace(token: token, id: id).then((value) {
                    Map<String, dynamic> data = jsonDecode(value);

                    showModalBottomSheet<void>(
                      context: context,
                      builder: (context) {
                        return ExpenseAddScreen(
                            cat: cat,
                            data: _data,
                            type: "add",
                            updateData: null,
                            count: data["count"]);
                      },
                    );
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: GlobalColors.white,
                  size: widget.width! < 700
                      ? widget.width! / 30
                      : widget.width! / 45,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.themeColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                label: Text(
                  "Add Expense",
                  style: GoogleFonts.ptSans(
                      color: GlobalColors.white,
                      fontSize: widget.width! < 700
                          ? widget.width! / 35
                          : widget.width! / 45,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0),
                ),
              );
            }),
            error: ((error, stackTrace) => Text("")),
            loading: (() => Text("")));
      })),
      body: expenseDetail.when(
          data: (_data) {
            return RefreshIndicator(
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
                                ? widget.height! * 0.3
                                : widget.height! * 0.18,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
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
                                        ? widget.height! * 0.3
                                        : widget.height! * 0.18,
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
                                          lable: "Expense Date",
                                          value: DateFormat("dd-MM-yyyy")
                                              .format(_data[i].date!),
                                        ),
                                        Consumer(
                                            builder: ((context, ref, child) {
                                          final cat = ref
                                              .watch(expenseCategoryProvider);
                                          return cat.when(
                                              data: ((data) {
                                                var newdata = data.firstWhere(
                                                    (element) =>
                                                        element.id ==
                                                        _data[i].categoryId);
                                                return TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Category",
                                                  value: "${newdata.name}",
                                                );
                                              }),
                                              error: ((error, stackTrace) =>
                                                  Text("")),
                                              loading: (() => Text("")));
                                        })),
                                        if (_data[i].categoryId == 1)
                                          TextRowWidget(
                                            width: widget.width!,
                                            lable: "Place",
                                            value: _data[i].fromPlace,
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
                                        ? widget.height! * 0.3
                                        : widget.height! * 0.18,
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
                                        Consumer(
                                            builder: ((context, ref, child) {
                                          final data = ref
                                              .watch(expenseCategoryProvider);
                                          return data.when(
                                              data: ((_data1) {
                                                cat = [];
                                                for (var i = 0;
                                                    i < _data1.length;
                                                    i++) {
                                                  cat.add(_data1[i].name!);
                                                }
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedId = null;
                                                    });

                                                    print(_data[i]
                                                        .categoryId
                                                        .toString());

                                                    if (_data[i].categoryId ==
                                                        1) {
                                                      QuickAlert.show(
                                                        context: context,
                                                        type: QuickAlertType
                                                            .error,
                                                        widget: Text(
                                                          "You con not edit this details. Please contact  admin",
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            color: GlobalColors
                                                                .black,
                                                            fontSize: widget
                                                                        .width! <
                                                                    700
                                                                ? widget.width! /
                                                                    35
                                                                : widget.width! /
                                                                    44,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                        autoCloseDuration: null,
                                                      );
                                                    } else {
                                                      showModalBottomSheet<
                                                          void>(
                                                        context: context,
                                                        builder: (context) {
                                                          return ExpenseAddScreen(
                                                            cat: cat,
                                                            data: _data1,
                                                            type: "update",
                                                            updateData:
                                                                _data[i],
                                                            count: null,
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Card(
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .penToSquare,
                                                        color: GlobalColors
                                                            .themeColor,
                                                        size: widget.width! <
                                                                700
                                                            ? widget.width! / 20
                                                            : widget.width! /
                                                                45,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              error: ((error, stackTrace) =>
                                                  Text("")),
                                              loading: (() => Text("")));
                                        })),
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
                    return ref.refresh(expenseProvider);
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

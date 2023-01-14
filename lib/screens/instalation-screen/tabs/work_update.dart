import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/add-workupdate.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../const/global_colors.dart';
import 'widget/add-expense-screen.dart';

class WorkUpdateScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const WorkUpdateScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<WorkUpdateScreen> createState() => _WorkUpdateScreenState();
}

class _WorkUpdateScreenState extends ConsumerState<WorkUpdateScreen> {
  List<String> cat = [];
  int? selectedId = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final data = ref.watch(workUpdateProvider);
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return AddWorkUpdate();
            },
          );
        },
        icon: Icon(
          Icons.work,
          color: GlobalColors.white,
          size: widget.width! < 700 ? widget.width! / 30 : widget.width! / 45,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.themeColor,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        label: Text(
          "Work",
          style: GoogleFonts.ptSans(
              color: GlobalColors.white,
              fontSize:
                  widget.width! < 700 ? widget.width! / 35 : widget.width! / 45,
              fontWeight: FontWeight.w400,
              letterSpacing: 0),
        ),
      ),
      body: data.when(
          data: (_data) {
            return RefreshIndicator(
              color: Colors.white,
              backgroundColor: GlobalColors.themeColor,
              strokeWidth: 4.0,
              onRefresh: () async {
                return Future<void>.delayed(const Duration(seconds: 2), () {
                  return ref.refresh(workUpdateProvider);
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
                    Column(
                      children: [
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
                                  elevation: 10,
                                  child: Container(
                                    width: widget.width! * 0.97,
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
                                          lable: "Participant",
                                          value:
                                              "${_data[i].participantsName!}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Siteincharge",
                                          value:
                                              "${_data[i].siteincharge!.name!}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Date",
                                          value: DateFormat("dd-MM-yyyy")
                                              .format(DateTime.parse(
                                                  _data[i].reportDate!)),
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "category",
                                          value: _data[i].taskcategory!.name,
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Description",
                                          value: "${_data[i].description!}",
                                        ),
                                        Divider(),
                                        Text(
                                          "Items",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.black,
                                              fontSize: widget.width! < 700
                                                  ? widget.width! / 34
                                                  : widget.width! / 45,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0),
                                        ),
                                        Container(
                                          width: widget.width,
                                          child: Card(
                                            elevation: 10,
                                            child: Column(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width:
                                                          widget.width! * 0.6,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Product Name",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
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
                                                    ),
                                                    Container(
                                                      width:
                                                          widget.width! * 0.15,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "unit",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
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
                                                    ),
                                                    Container(
                                                      width:
                                                          widget.width! * 0.15,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Used Qty",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .themeColor,
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              for (var j = 0;
                                                  j < _data[i].items!.length;
                                                  j++)
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width:
                                                            widget.width! * 0.6,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _data[i]
                                                              .items![j]!
                                                              .product!
                                                              .name!,
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            color: GlobalColors
                                                                .themeColor2,
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
                                                      ),
                                                      Container(
                                                        width: widget.width! *
                                                            0.15,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _data[i]
                                                              .items![j]!
                                                              .unit!
                                                              .shortName!,
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            color: GlobalColors
                                                                .themeColor2,
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
                                                      ),
                                                      Container(
                                                        width: widget.width! *
                                                            0.15,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          _data[i]
                                                              .items![j]!
                                                              .quantity!,
                                                          style: GoogleFonts
                                                              .ptSans(
                                                            color: GlobalColors
                                                                .themeColor2,
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
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  Container(
                    width: widget.width,
                    height: widget.height! * 0.1,
                    child: Text(""),
                  )
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
                              "Not Available $err",
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

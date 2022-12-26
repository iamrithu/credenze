import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../const/global_colors.dart';

class TaskScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const TaskScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final taskDetail = ref.watch(taskProvider);
    return taskDetail.when(
        data: (_data) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: GlobalColors.themeColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                return ref.refresh(taskProvider);
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
                              style: GoogleFonts.akayaKanadaka(
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
                  Container(
                    width: widget.width,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: GlobalColors.themeColor2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: widget.width! * 0.8,
                                child: Column(
                                  children: [
                                    TextRowWidget(
                                      width: widget.width!,
                                      lable: "Task Id",
                                      value: "#${_data[i].id!}",
                                    ),
                                    TextRowWidget(
                                      width: widget.width!,
                                      lable: "Description",
                                      value: "${_data[i].description!}",
                                    ),
                                    TextRowWidget(
                                      width: widget.width!,
                                      lable: "Start Date",
                                      value:
                                          "${DateFormat("dd - MMMM - yyyy ").format(_data[i].startDate!)}",
                                    ),
                                    TextRowWidget(
                                      width: widget.width!,
                                      lable: "End Date",
                                      value:
                                          "${DateFormat("dd - MMMM - yyyy ").format(_data[i].endDate!)}",
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: widget.width! * 0.27,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: widget.width! * 0.03),
                                            child: Text(
                                              "Category",
                                              style: GoogleFonts.akayaKanadaka(
                                                  fontSize: widget.width! < 700
                                                      ? widget.width! / 32
                                                      : widget.width! / 45,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  letterSpacing: 0),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: widget.width! * 0.02),
                                          child: Container(
                                            width: widget.width! * 0.45,
                                            child: HtmlWidget(
                                              "${_data[i].categoryName!}",
                                              textStyle:
                                                  GoogleFonts.akayaKanadaka(
                                                      fontSize: widget.width! <
                                                              700
                                                          ? widget.width! / 32
                                                          : widget.width! / 45,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: GlobalColors
                                                          .themeColor,
                                                      letterSpacing: 0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        )),
                  ),
              ],
            ),
          );
        },
        error: (err, s) =>
            Text("Not authenticated to perform this request   $err"),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

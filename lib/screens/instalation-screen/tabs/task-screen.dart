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
    final taskDetail = ref.watch(installationTaskProvider);
    return taskDetail.when(
        data: (_data) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: GlobalColors.themeColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                return ref.refresh(installationTaskProvider);
              });
            },
            child: _data.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "No Information Available",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.themeColor2,
                              fontSize: widget.width! < 700
                                  ? widget.width! / 30
                                  : widget.width! / 45,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    children: [
                      for (var i = 0; i < _data.length; i++)
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                ref
                                    .read(taskId.notifier)
                                    .update((state) => _data[i].id!);
                                ref
                                    .read(pageIndex.notifier)
                                    .update((state) => 6);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 249, 188, 189)),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Container(
                                  width: widget.width,
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
                                            width: widget.width! * 0.9,
                                            child: Column(
                                              children: [
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Task Id",
                                                  value: "#${_data[i].id!}",
                                                ),
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Category",
                                                  value:
                                                      "${_data[i].category!.name ?? "--"}",
                                                ),
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Description",
                                                  value:
                                                      "${_data[i].taskDescription ?? "--"}",
                                                ),
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Start Date",
                                                  value: _data[i].startDate ==
                                                          null
                                                      ? "--"
                                                      : "${DateFormat("dd - MMMM - yyyy ").format(_data[i].startDate!)}",
                                                ),
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "End Date",
                                                  value: _data[i].endDate ==
                                                          null
                                                      ? "--"
                                                      : "${DateFormat("dd - MMMM - yyyy ").format(_data[i].endDate!)}",
                                                ),
                                                TextRowWidget(
                                                  width: widget.width!,
                                                  lable: "Status",
                                                  value: _data[i]
                                                          .taskStatus!
                                                          .toString()[0]
                                                          .toUpperCase() +
                                                      _data[i]
                                                          .taskStatus!
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
                            ),
                          ],
                        ),
                    ],
                  ),
          );
        },
        error: (err, s) => Center(child: Text("No Datas Available")),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

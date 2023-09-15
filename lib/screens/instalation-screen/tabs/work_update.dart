import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/add-workupdate.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/workUpdateDetails.dart/workUpdateDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../const/global_colors.dart';

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
  List<TextEditingController> textEditingControllers = [];
  List<String> cat = [];
  int? selectedId = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final data = ref.watch(workUpdateListProvider);

    onRefresh() async {
      return Future<void>.delayed(const Duration(seconds: 1), () {
        return ref.refresh(workUpdateListProvider);
      });
    }

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          //  Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => AddWorkUpdate(
          //           onclick: onRefresh,
          //         )));
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddWorkUpdate(
                  onclick: onRefresh,
                ),
              );
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
                  return ref.refresh(workUpdateListProvider);
                });
              },
              child: ListView(
                children: [
                  if (_data.isEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "-- Data not found --",
                          style: GoogleFonts.ptSans(
                              fontSize: widget.width! < 700
                                  ? widget.width! / 40
                                  : widget.width! / 45,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 50, 49, 49),
                              letterSpacing: 0),
                        ),
                      ],
                    ),
                  for (var i = 0; i < _data.length; i++)
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return WorkUpdateDetailsScreen(
                                  height: widget.height,
                                  width: widget.width,
                                  id: _data[i].id!);
                            });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 249, 188, 189)),
                            borderRadius: BorderRadius.circular(4)),
                        child: Container(
                          width: widget.width,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: widget.width! * 0.9,
                                    child: Column(
                                      children: [
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: " Id",
                                          value: "#${_data[i].id!}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Members",
                                          value: "${_data[i].participantsName}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Task",
                                          value:
                                              "${_data[i].category!.name ?? "--"}",
                                        ),
                                        TextRowWidget(
                                          width: widget.width!,
                                          lable: "Work Updated Date",
                                          value:
                                              "${DateFormat("dd - MMMM - yyyy ").format(_data[i].workupdateDate!)}",
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
                              "No Information Available",
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

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/add-workupdate.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:credenze/screens/services-screen/service-tabs/work-update/workUpdateDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'add-wrokUpdate.dart';

class ServiceWorkUpdateScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const ServiceWorkUpdateScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<ServiceWorkUpdateScreen> createState() =>
      _ServiceWorkUpdateScreenState();
}

class _ServiceWorkUpdateScreenState
    extends ConsumerState<ServiceWorkUpdateScreen> {
  List<String> cat = [];
  int? selectedId = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final data = ref.watch(serviceWrokupdateListProvider);

    onRefresh() async {
      return Future<void>.delayed(const Duration(seconds: 1), () {
        return ref.refresh(serviceWrokupdateListProvider);
      });
    }

    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return ServiceAddWorkUpdate(
                onclick: onRefresh,
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
                  return ref.refresh(serviceWrokupdateListProvider);
                });
              },
              child: ListView(
                children: [
                  for (var i = 0; i < _data.length; i++)
                    InkWell(
                      onTap: (){
                         showModalBottomSheet(
                          isScrollControlled:true,
                            context: context,
                            builder: (context) {
                              return ServiceWorkUpdateDetailsScreen (height:widget.height,width: widget.width,id:_data[i].id!);
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

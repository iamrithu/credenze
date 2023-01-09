import 'package:credenze/apis/api.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/add-workupdate.dart';
import 'package:credenze/screens/instalation-screen/tabs/widget/text-row-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final expenseDetail = ref.watch(expenseProvider);
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
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      return AddWorkUpdate(
                          cat: cat, data: _data, updateData: null);
                    },
                  );
                },
                icon: Icon(
                  Icons.work,
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
                  "Work",
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
                  for (var i = 0; i < _data.length; i++) Text("data")
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

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../const/global_colors.dart';

class ServiceMemberScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const ServiceMemberScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<ServiceMemberScreen> createState() =>
      _ServiceMemberScreenState();
}

class _ServiceMemberScreenState extends ConsumerState<ServiceMemberScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final memberDetails = ref.watch(serviceMembersProvider);

    final user_id = ref.watch(userId);
    return memberDetails.when(
        data: (_data) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: GlobalColors.themeColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              return Future<void>.delayed(const Duration(seconds: 2), () {
                return ref.refresh(serviceMembersProvider);
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
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: GlobalColors.themeColor,
                        child: Container(
                          width: widget.width,
                          height: widget.height! * 0.15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: GlobalColors.white,
                            child: Container(
                              width: widget.width! * 0.97,
                              height: widget.height! * 0.15,
                              alignment: Alignment.center,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(_data[i].user!.imageUrl!),
                                ),
                                isThreeLine: true,
                                title: RichText(
                                  text: TextSpan(
                                      text:
                                          _data[i].user!.name.toString() + " ",
                                      style: GoogleFonts.ptSans(
                                          fontSize: widget.width! < 700
                                              ? widget.width! / 28
                                              : widget.width! / 46,
                                          fontWeight: FontWeight.w400,
                                          color: GlobalColors.themeColor,
                                          letterSpacing: 0),
                                      children: [
                                        user_id == _data[i].user!.id
                                            ? TextSpan(
                                                text: " it's you ",
                                                style: GoogleFonts.ptSans(
                                                    backgroundColor:
                                                        GlobalColors
                                                            .themeColor2,
                                                    fontSize: widget.width! <
                                                            700
                                                        ? widget.width! / 45
                                                        : widget.width! / 48,
                                                    fontWeight: FontWeight.w400,
                                                    color: GlobalColors.white,
                                                    letterSpacing: 2),
                                              )
                                            : TextSpan(),
                                      ]),
                                ),
                                trailing: _data[i].siteIncharge == 1
                                    ? Text(
                                        "In-charge",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.ptSans(
                                            fontSize: widget.width! < 700
                                                ? widget.width! / 30
                                                : widget.width! / 42,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.green,
                                            letterSpacing: 0),
                                      )
                                    : Text(""),
                                subtitle: RichText(
                                  text: TextSpan(
                                      text: _data[i]
                                              .user!
                                              .employeeDetail!
                                              .designation!
                                              .name! +
                                          "  ",
                                      style: GoogleFonts.ptSans(
                                          fontSize: widget.width! < 700
                                              ? widget.width! / 35
                                              : widget.width! / 45,
                                          fontWeight: FontWeight.w400,
                                          color: GlobalColors.themeColor2,
                                          letterSpacing: 0),
                                      children: [
                                        TextSpan(text: "\n"),
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "\nAssign Date : ",
                                            style: GoogleFonts.ptSans(
                                                fontSize: widget.width! < 700
                                                    ? widget.width! / 35
                                                    : widget.width! / 45,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor2,
                                                letterSpacing: 0),
                                          ),
                                          TextSpan(
                                            text: DateFormat(
                                                    "dd - MMMM - yyyy ")
                                                .format(_data[i].assignDate!),
                                            style: GoogleFonts.ptSans(
                                                fontSize: widget.width! < 700
                                                    ? widget.width! / 35
                                                    : widget.width! / 45,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.black,
                                                letterSpacing: 0),
                                          ),
                                        ])
                                      ]),
                                ),
                                selected: true,
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
        error: (err, s) => Center(
              child: Text(
                "No Informations Available",
                style: GoogleFonts.ptSans(
                    color: GlobalColors.black,
                    fontSize: widget.width! < 700
                        ? widget.width! / 30
                        : widget.width! / 45,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0),
              ),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ));
  }
}

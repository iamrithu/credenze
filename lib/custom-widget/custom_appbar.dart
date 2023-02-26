import 'package:credenze/const/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../river-pod/riverpod_provider.dart';

class CustomAppBar extends ConsumerWidget {
  final int page;
  const CustomAppBar({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (() async {
        return false;
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: page > 0
              ? IconButton(
                  onPressed: () {
                    ref.read(pageIndex.notifier).update((state) => page == 4
                        // ? 3
                        // : page == 6
                        ? 1
                        : page == 5
                            ? 4
                            : 0);
                  },
                  color: GlobalColors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: height * 0.025,
                  ),
                )
              : Card(
                  elevation: 10,
                  child: Container(
                    child: Image(
                      image: AssetImage("Assets/images/icon.png"),
                    ),
                  ),
                ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: GlobalColors.white,
              systemStatusBarContrastEnforced: true),
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.all(10),
            child: page == 0
                ? Text(
                    "Dashboard",
                    style: GoogleFonts.ptSans(
                        fontSize: width < 700 ? width / 20 : width / 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0),
                  )
                : page == 1
                    ? Text(
                        "My Installations",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 20 : width / 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0),
                      )
                    : page == 2
                        ? Text(
                            "Attendence",
                            style: GoogleFonts.ptSans(
                                fontSize: width < 700 ? width / 20 : width / 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0),
                          )
                        // : page == 3
                        // ? Text(
                        // "Leads",
                        // style: GoogleFonts.ptSans(
                        // fontSize:
                        // width < 700 ? width / 20 : width / 24,
                        // fontWeight: FontWeight.w800,
                        // letterSpacing: 0),
                        // )
                        : page == 3
                            ? Text(
                                "Profile",
                                style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 20 : width / 24,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0),
                              )
                            // : page == 5
                            // ? Text(
                            // "Lead Details",
                            // style: GoogleFonts.ptSans(
                            // fontSize: width < 700
                            // ? width / 20
                            // : width / 24,
                            // fontWeight: FontWeight.w800,
                            // letterSpacing: 0),
                            // )
                            : Text(
                                "Installation Details",
                                style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 20 : width / 24,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0),
                              ),
          ),
          actions: [],
        ),
      ),
    );
  }
}

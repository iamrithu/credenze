import 'package:credenze/const/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final int page;
  const CustomAppBar({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: GlobalColors.white,
            systemStatusBarContrastEnforced: true),
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.all(10),
          child: page == 0
              ? Text(
                  "DASHBOARD",
                  style: GoogleFonts.akayaKanadaka(
                      fontSize: width < 700 ? width / 20 : width / 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0),
                )
              : page == 1
                  ? Text(
                      "INSTALLATION",
                      style: GoogleFonts.akayaKanadaka(
                          fontSize: width < 700 ? width / 20 : width / 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0),
                    )
                  : page == 2
                      ? Text(
                          "ATTENDENCE",
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 20 : width / 24,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0),
                        )
                      : page == 3
                          ? Text(
                              "LEADS",
                              style: GoogleFonts.akayaKanadaka(
                                  fontSize:
                                      width < 700 ? width / 20 : width / 24,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0),
                            )
                          : page == 4
                              ? Text(
                                  "PROFILE",
                                  style: GoogleFonts.akayaKanadaka(
                                      fontSize:
                                          width < 700 ? width / 20 : width / 24,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0),
                                )
                              : Text(
                                  "LEADS DETAILS",
                                  style: GoogleFonts.akayaKanadaka(
                                      fontSize:
                                          width < 700 ? width / 20 : width / 24,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0),
                                ),
        ),
        actions: [],
      ),
    );
  }
}

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../const/global_colors.dart';
import 'widgets/lead_custom_input.dart';

class LeadListingScreen extends StatefulWidget {
  const LeadListingScreen({Key? key}) : super(key: key);

  @override
  _LeadListingScreenState createState() => _LeadListingScreenState();
}

class _LeadListingScreenState extends State<LeadListingScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            width: width,
            height: height * 0.7,
            padding: EdgeInsets.all(6),
            child: ListView(
              children: [
                Consumer(builder: (context, ref, child) {
                  return InkWell(
                    onTap: () {
                      ref.read(pageIndex.notifier).update((state) => 5);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: width,
                        height: height * 0.18,
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.7,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Lead Id",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Text(
                                          "#1",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.black,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Lead Name",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Text(
                                          "Mr Rithi Mahesh Kumar",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.black,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Company Name",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Text(
                                          "Themeparrot",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.black,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Created   ",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Text(
                                          "06-12-2022",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.black,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Lead Value ",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Text(
                                          "10000 Rs",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.black,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.25,
                                        child: Text(
                                          "Lead Agend   ",
                                          style: GoogleFonts.akayaKanadaka(
                                              color: GlobalColors.themeColor2,
                                              fontSize: width < 700
                                                  ? width / 30
                                                  : width / 45,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.45,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Mrs Prabavathi",
                                              style: GoogleFonts.akayaKanadaka(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 45,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0),
                                            ),
                                            Text(
                                              "Pending",
                                              style: GoogleFonts.akayaKanadaka(
                                                  color: Color.fromARGB(
                                                      255, 225, 198, 27),
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 45,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.17,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (!await launchUrl(
                                        Uri(
                                            scheme: 'https',
                                            host: 'wa.me',
                                            path: '918675784449'),
                                        mode: LaunchMode.externalApplication,
                                      )) {
                                        throw 'Could not launch';
                                      }
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.whatsapp,
                                          color:
                                              Color.fromARGB(255, 73, 192, 77),
                                          size: width < 700
                                              ? width / 25
                                              : width / 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final Uri _url = Uri.parse(
                                          'mailto:ritimahesh29@gmail.com?subject=hi');
                                      await launchUrl(_url);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.email,
                                          color:
                                              Color.fromARGB(255, 41, 134, 222),
                                          size: width < 700
                                              ? width / 25
                                              : width / 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final Uri launchUri = Uri(
                                        scheme: 'tel',
                                        path: "7708708978",
                                      );
                                      await launchUrl(launchUri);
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.phone,
                                          color:
                                              Color.fromARGB(255, 17, 47, 116),
                                          size: width < 700
                                              ? width / 25
                                              : width / 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final Uri _url =
                                          Uri.parse('sms:7708708978');
                                      await launchUrl(_url);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.sms,
                                          color:
                                              Color.fromARGB(255, 192, 158, 73),
                                          size: width < 700
                                              ? width / 25
                                              : width / 45,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            )));
  }
}

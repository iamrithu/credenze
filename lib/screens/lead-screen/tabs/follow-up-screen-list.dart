import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../const/global_colors.dart';

class FollowUpListScreen extends StatefulWidget {
  const FollowUpListScreen({Key? key}) : super(key: key);

  @override
  _FollowUpListScreenState createState() => _FollowUpListScreenState();
}

class _FollowUpListScreenState extends State<FollowUpListScreen> {
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
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    width: width,
                    height: height * 0.18,
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: width * 0.25,
                                    child: Text(
                                      "Lead Id",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.themeColor2,
                                          fontSize: width < 700
                                              ? width / 35
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.45,
                                    child: Text(
                                      "#1",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 35
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
                                      "Follow Up Date",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.themeColor2,
                                          fontSize: width < 700
                                              ? width / 35
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.45,
                                    child: Text(
                                      "14 Dec 2022",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 35
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
                                      "Follow Up Time",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.themeColor2,
                                          fontSize: width < 700
                                              ? width / 35
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.45,
                                    child: Text(
                                      "2:30 AM",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 35
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
                                      "Remarks",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.themeColor2,
                                          fontSize: width < 700
                                              ? width / 35
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.45,
                                    child: Text(
                                      "Need a conversation for understading thier products",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 35
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.whatsapp,
                                      color: Color.fromARGB(255, 73, 192, 77),
                                      size:
                                          width < 700 ? width / 25 : width / 45,
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
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.email,
                                      color: Color.fromARGB(255, 41, 134, 222),
                                      size:
                                          width < 700 ? width / 25 : width / 45,
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
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.phone,
                                      color: Color.fromARGB(255, 17, 47, 116),
                                      size:
                                          width < 700 ? width / 25 : width / 45,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final Uri _url = Uri.parse('sms:7708708978');
                                  await launchUrl(_url);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  elevation: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.sms,
                                      color: Color.fromARGB(255, 192, 158, 73),
                                      size:
                                          width < 700 ? width / 25 : width / 45,
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
                )
              ],
            )));
  }
}

import 'package:credenze/screens/lead-screen/tabs/add-follow-up-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/global_colors.dart';
import '../../../custom-widget/custom_information.dart';
import '../../../river-pod/riverpod_provider.dart';
import '../../home-screen/home_screen.dart';

class LeadDetailsScreen extends StatefulWidget {
  const LeadDetailsScreen({Key? key}) : super(key: key);

  @override
  _LeadDetailsScreenState createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return AddFollowUpScreen();
            },
          );
        },
        icon: Icon(Icons.add,
            color: GlobalColors.white,
            size: width < 700 ? width / 28 : width / 45),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.themeColor,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        label: Text(
          " Add Follow Up",
          style: GoogleFonts.akayaKanadaka(
              color: GlobalColors.white,
              fontSize: width < 700 ? width / 28 : width / 45,
              fontWeight: FontWeight.w400,
              letterSpacing: 0),
        ),
      ),
      body: Container(
          width: width,
          height: height * 0.85,
          child: ListView(
            children: [
              // Row(
              //   children: [
              //     Consumer(builder: ((context, ref, child) {
              //       return Container(
              //         margin: EdgeInsets.symmetric(horizontal: width * 0.05),
              //         alignment: Alignment.centerLeft,
              //         decoration: BoxDecoration(
              //             color: GlobalColors.themeColor,
              //             borderRadius: BorderRadius.circular(10)),
              //         child: IconButton(
              //           color: GlobalColors.themeColor,
              //           icon: Icon(
              //             Icons.arrow_back_ios_new,
              //             size: width < 700 ? width / 28 : width / 45,
              //             color: GlobalColors.white,
              //           ),
              //           onPressed: () {
              //             ref.read(pageIndex.notifier).update((state) => 3);
              //           },
              //         ),
              //       );
              //     })),
              //   ],
              // ),
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(left: 20),
                width: width,
                height: height * 0.03,
                alignment: Alignment.centerLeft,
                child: Text(
                  "PROFILE INFORMATION :  ",
                  style: GoogleFonts.akayaKanadaka(
                      fontSize: width < 700 ? width / 28 : width / 45,
                      fontWeight: FontWeight.w500,
                      color: GlobalColors.black,
                      letterSpacing: 0),
                ),
              ),
              CustomInformationScreen(
                  label: "Lead Name", text: "Mr Rithi Mahesh Kumar"),
              CustomInformationScreen(
                  label: "Lead Email", text: "ritimahesh29@gmail.com"),
              CustomInformationScreen(
                  label: "Company Name", text: "ThemeParrot"),
              CustomInformationScreen(
                  label: "Website", text: "www.themeparrot.com"),
              CustomInformationScreen(label: "Mobile", text: "7708708978"),
              CustomInformationScreen(label: "Ofice Phone", text: "--"),
              CustomInformationScreen(label: "Country", text: "India"),
              CustomInformationScreen(label: "State", text: "Tamil Nadu"),
              CustomInformationScreen(label: "City", text: "Coimbatore"),
              CustomInformationScreen(label: "Postal Code", text: "641004"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: width * 0.04),
                      width: width * 0.3,
                      child: Text(
                        "Address",
                        style: GoogleFonts.akayaKanadaka(
                            fontSize: width < 700 ? width / 28 : width / 47,
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.themeColor,
                            letterSpacing: 0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 25,
                        ),
                        width: width * 0.6,
                        child: Text(
                          "436,6th Cross .Chrttiar Thaneer Pandal,Vilankurichi Rd, near Allied castings,Peelamedu,B.S. Puram Industrial Estate, Coimbatore, Tamil Nadu.",
                          softWrap: true,
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              color: GlobalColors.black,
                              letterSpacing: 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomInformationScreen(
                  label: "Lead Agent", text: "Mrs PRabavathi"),
              CustomInformationScreen(
                  label: "Lead Source", text: "Direct Visit"),
              CustomInformationScreen(label: "Status", text: "Pending"),
              CustomInformationScreen(label: "Lead Value", text: "10000"),
              CustomInformationScreen(
                  label: "Note",
                  text:
                      "Client will discuss with their team and get back to us."),
              Container(
                width: width,
                height: height * 0.05,
                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Row(
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
                            size: width < 700 ? width / 25 : width / 45,
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
                            size: width < 700 ? width / 25 : width / 45,
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
                            size: width < 700 ? width / 25 : width / 45,
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
                            size: width < 700 ? width / 25 : width / 45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

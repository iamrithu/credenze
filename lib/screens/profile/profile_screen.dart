import 'package:credenze/custom-widget/custom_information.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/login-screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/api.dart';
import '../../const/global_colors.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer(builder: ((context, ref, child) {
      final user = ref.watch(userDataProvider);
      return user.when(
          data: (_data) {
            return Container(
              width: width,
              height: width < 700 ? height * 0.8 : height * 0.86,
              child: Scaffold(
                floatingActionButton: ElevatedButton.icon(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('Email', "");
                    await prefs.setString('Password', "");
                    await prefs.setString('token', "");
                    Navigator.push(context, MaterialPageRoute(
                      builder: ((context) {
                        return const LoginScreen();
                      }),
                    ));
                    ref.read(pageIndex.notifier).update((state) => 0);
                  },
                  icon: Icon(
                    FontAwesomeIcons.leftLong,
                    color: GlobalColors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.themeColor,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  label: Text(
                    "Log Out",
                    style: GoogleFonts.akayaKanadaka(
                        color: GlobalColors.white,
                        fontSize: width < 700 ? width / 28 : width / 45,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0),
                  ),
                ),
                body: ListView(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: GlobalColors.themeColor)),
                      elevation: 10,
                      child: Container(
                        width: width,
                        height: height * 0.15,
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        _data.imageUrl.toString())),
                              ),
                            ),
                            Container(
                              width: width * 0.67,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _data.name!,
                                    style: GoogleFonts.akayaKanadaka(
                                        fontSize: width < 700
                                            ? width / 20
                                            : width / 42,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.themeColor,
                                        letterSpacing: 0),
                                  ),
                                  Text(
                                    _data.employeeDetail!.designation!.name!,
                                    style: GoogleFonts.akayaKanadaka(
                                        fontSize: width < 700
                                            ? width / 24
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: "Employee Id : ",
                                        style: GoogleFonts.akayaKanadaka(
                                            fontSize: width < 700
                                                ? width / 26
                                                : width / 44,
                                            fontWeight: FontWeight.w400,
                                            color: GlobalColors.black,
                                            letterSpacing: 0),
                                        children: [
                                          TextSpan(
                                            text: _data.employeeDetail!.id!
                                                .toString(),
                                            style: GoogleFonts.akayaKanadaka(
                                                fontSize: width < 700
                                                    ? width / 24
                                                    : width / 44,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor,
                                                letterSpacing: 0),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      elevation: 5,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            padding: EdgeInsets.only(left: 20),
                            width: width,
                            height: height * 0.03,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ADDITIONAL INFORMATION :  ",
                              style: GoogleFonts.akayaKanadaka(
                                  fontSize:
                                      width < 700 ? width / 28 : width / 45,
                                  fontWeight: FontWeight.w500,
                                  color: GlobalColors.black,
                                  letterSpacing: 0),
                            ),
                          ),
                          CustomInformationScreen(
                              label: "Email", text: _data.email!),
                          CustomInformationScreen(
                              label: "Mobile",
                              text: _data.employeeDetail!.mobileOne!),
                          CustomInformationScreen(
                              label: "Phone",
                              text: _data.employeeDetail!.whatsappNo!),
                          CustomInformationScreen(
                              label: "Gender", text: _data.gender!),
                          CustomInformationScreen(
                              label: "State",
                              text: _data.employeeDetail!.permanentAddState!),
                          CustomInformationScreen(
                              label: "City",
                              text: _data.employeeDetail!.permanentAddCity!),
                          CustomInformationScreen(
                              label: "Pin-Code",
                              text: _data.employeeDetail!.permanentAddPincode!),
                          Container(
                            width: width,
                            height: height * 0.08,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.056),
                                  width: width * 0.35,
                                  child: Text(
                                    "Address",
                                    style: GoogleFonts.akayaKanadaka(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 47,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.themeColor,
                                        letterSpacing: 0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  padding: EdgeInsets.only(right: 5),
                                  width: width * 0.6,
                                  child: Text(
                                    "${_data.employeeDetail!.permanentAddress!} ",
                                    softWrap: true,
                                    style: GoogleFonts.akayaKanadaka(
                                        fontSize: width < 700
                                            ? width / 28
                                            : width / 45,
                                        fontWeight: FontWeight.w400,
                                        color: GlobalColors.black,
                                        letterSpacing: 0),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (err, s) =>
              Center(child: Text("Not authenticated to perform this request")),
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ));
    }));
  }
}

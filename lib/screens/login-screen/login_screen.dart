// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/custom-widget/custom_alertbox.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:credenze/screens/home-screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import 'package:get/get.dart';

import '../../apis/api.dart';
import '../../custom-widget/custom_input.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String msg = "";
  bool visible = false;
  bool success = false;
  bool isChecked = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  getStayinData(bool click) async {
    final prefs = await SharedPreferences.getInstance();
    final String? getEmail = prefs.getString('Email');
    final String? getPassword = prefs.getString('Password');

    if (click) {
      return getLoginData();
    }
    if (getEmail != null &&
        getEmail != "" &&
        getPassword != null &&
        getPassword != "") {
      Timer(Duration(milliseconds: 400), () {
        _emailController.text = getEmail;
        _passwordController.text = getPassword;
      });
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          isChecked = true;
        });
        getLoginData();
      });
    }
  }

  setToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token!);
  }

  getLoginData() async {
    Api()
        .authendication(_emailController.text, _passwordController.text)
        .then((value) {
      if (value.statusCode == 200) {
        return setState(() {
          setToken(value.data["data"]["token"]);
          print("from login" + value.data["data"]["token"]);

          ref
              .read(newToken.notifier)
              .update((state) => value.data["data"]["token"]);

          visible = true;
          msg = "Loged In Successfully";
          success = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              visible = false;
              success = false;
            });
          });
          Timer(const Duration(milliseconds: 1400), () {
            Get.to(HomeScreen(),
                transition: Transition.fade,
                duration: Duration(milliseconds: 300));
          });
          if (isChecked) {
            setLoggedInDetails(_emailController.text, _passwordController.text);
          } else {
            setLoggedInDetails("", "");
          }
        });
      } else {
        setState(() {
          visible = true;
          msg = value.statusMessage.toString();
        });

        Timer(const Duration(seconds: 3), () {
          setState(() {
            visible = false;
            success = false;
          });
        });
      }
    });
  }

  internetConnectivity(value) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      getStayinData(value);
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: "No Internet Connection",
          autoCloseDuration: null);
    }
  }

  @override
  void initState() {
    super.initState();
    internetConnectivity(false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  setLoggedInDetails(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('Email', email);
    await prefs.setString('Password', password);
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    login() async {
      if (!_emailController.text.contains("@")) {
        setState(() {
          visible = true;
          msg = "Please Enter Valid Email";
        });
      }
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        setState(() {
          visible = true;
          msg = "Please Enter The Values";
        });
      }
      if (!visible) {
        internetConnectivity(true);
      }

      if (visible) {
        Timer(const Duration(seconds: 3), () {
          setState(() {
            visible = false;
            success = false;
          });
        });
      }
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return GlobalColors.themeColor2;
      }
      return GlobalColors.themeColor;
    }

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: height * 0.1),
              width: width,
              height: height,
              color: GlobalColors.themeColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset('Assets/json/cctv.json', width: width * 0.4),
                ],
              ),
            ),
            Container(
              width: width,
              height: height * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(100),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomAlertBox(
                            success: success,
                            visible: visible,
                            width: width,
                            height: height,
                            msg: msg),
                      ],
                    ),
                  ),
                  Center(
                    child: Card(
                      elevation: 10,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage("Assets/images/logo.png"),
                          width: width * 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: height * 0.35,
                right: width * 0.1,
                child: Container(
                  height: height * 0.35,
                  width: width * 0.8,
                  child: Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: GlobalColors.themeColor)),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "LOGIN",
                            style: GoogleFonts.abel(
                                color: GlobalColors.themeColor,
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          ),
                          CustomInputForm(
                            controller: _emailController,
                            lable: "Email",
                          ),
                          CustomInputForm(
                            controller: _passwordController,
                            lable: "Password",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: isChecked,
                                onChanged: (bool? value) async {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text(
                                "Stay Logged In",
                                style: GoogleFonts.abel(
                                    color: GlobalColors.themeColor2,
                                    fontSize: width * 0.028,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                minimumSize: Size(width * 0.7, height * 0.05)),
                            onPressed: visible
                                ? null
                                : () {
                                    login();
                                  },
                            icon: Icon(Icons.arrow_forward_sharp),
                            label: Text("Login"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

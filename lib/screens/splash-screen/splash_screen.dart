// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/login-screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getDatas() async {
     Timer(const Duration(milliseconds:3000), () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));});
  }

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          width: width,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                color: GlobalColors.themeColor,
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.white,
                ),
                child: Center(
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
              ),
            ],
          )),
    );
  }
}

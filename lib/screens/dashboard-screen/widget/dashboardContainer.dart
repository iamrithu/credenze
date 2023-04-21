import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/global_colors.dart';

class CardContainer extends StatefulWidget {
  final String title;
  final String value;
  const CardContainer({Key? key,  required this.title, required this.value}) : super(key: key);

  @override
  _CardContainerState createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 252, 227, 226),
                Color.fromARGB(255, 247, 247, 247)
              ],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),),
        width: width * 0.26,
        height: width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Text(
                  textAlign:TextAlign.center,
                  "${widget.title}",
                  style: GoogleFonts.ptSans(
                    
                      fontSize: width < 700
                          ? width / 32
                          : width / 40,
                      fontWeight: FontWeight.w500,
                      color: GlobalColors.themeColor,
                      letterSpacing: 0),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                   textAlign:TextAlign.center,
                  "${widget.value}",
                  style: GoogleFonts.ptSans(
                      fontSize: width < 700
                          ? width / 25
                          : width / 40,
                      fontWeight: FontWeight.w500,
                      color:GlobalColors.themeColor,
                      letterSpacing: 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

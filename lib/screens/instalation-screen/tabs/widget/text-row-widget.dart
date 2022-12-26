import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';

class TextRowWidget extends StatelessWidget {
  final double width;
  final String? lable;
  final String? value;
  const TextRowWidget({Key? key, required this.width, this.lable, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.3,
            child: Text(
              lable!,
              style: GoogleFonts.akayaKanadaka(
                  fontSize: width < 700 ? width / 32 : width / 45,
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.themeColor2,
                  letterSpacing: 0),
            ),
          ),
          Container(
            width: width * 0.42,
            child: Text(
              value!,
              style: GoogleFonts.akayaKanadaka(
                  fontSize: width < 700 ? width / 32 : width / 45,
                  fontWeight: FontWeight.w400,
                  color: GlobalColors.black,
                  letterSpacing: 0),
            ),
          )
        ],
      ),
    );
  }
}

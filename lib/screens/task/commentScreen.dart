import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/global_colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.4,
      child: Card(
        elevation: 10,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No Commend Found",
                style: GoogleFonts.ptSans(
                    color: GlobalColors.black,
                    fontSize: width < 700 ? width / 35 : width / 45,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

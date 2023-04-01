import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/global_colors.dart';

class AlertDialogBox extends StatefulWidget {
  final Function onclikc;
  const AlertDialogBox({Key? key, required this.onclikc}) : super(key: key);

  @override
  _AlertDialogBoxState createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Stack(
        children: [],
      ),
    );
    ;
  }
}

import 'package:credenze/const/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputForm extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const CustomInputForm(
      {super.key, required this.label, required this.controller});

  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(color: GlobalColors.themeColor)),
      borderOnForeground: false,
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.55,
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: TextFormField(
                controller: widget.controller,
                obscureText: widget.label == "Password" ? obscureText : false,
                decoration: InputDecoration(
                  label: Text(
                    widget.label,
                    style: GoogleFonts.ptSans(
                        color: GlobalColors.themeColor2,
                        fontSize: width < 700 ? width / 28 : width / 45,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0),
                  ),
                  border: InputBorder.none,
                )),
          ),
          if (widget.label == "Password")
            IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? Icon(Icons.visibility_off_rounded)
                    : Icon(Icons.visibility_rounded)),
          if (widget.label == "Email")
            IconButton(onPressed: () {}, icon: Icon(Icons.email))
        ],
      ),
    );
  }
}

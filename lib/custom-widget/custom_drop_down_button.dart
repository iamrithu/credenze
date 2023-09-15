import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/global_colors.dart';

class CustomDropDownButton extends StatefulWidget {
  final String leaveType;
  final List<String> leaveTypeList;
  final Function function;
  const CustomDropDownButton(
      {Key? key,
      required this.leaveType,
      required this.leaveTypeList,
      required this.function})
      : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.65,
      height: height * 0.05,
      padding: EdgeInsets.only(left: width * 0.08, right: width * 0.057),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: GlobalColors.themeColor2),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(4),
        value: widget.leaveType,
        underline: Text(""),
        isExpanded: true,
        autofocus: true,
        menuMaxHeight: height * 0.2,
        icon: Icon(Icons.arrow_downward, color: GlobalColors.themeColor),
        onChanged: (String? value) {
          widget.function(value);
        },
        items:
            widget.leaveTypeList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value[0].toUpperCase() + value.substring(1).replaceAll("_", " "),
              style: GoogleFonts.ptSans(
                color: value.toLowerCase() == "casual"
                    ? Colors.green
                    : value.toLowerCase() == "earned"
                        ? Colors.purple
                        : value.toLowerCase() == "sick"
                            ? Colors.red
                            : Colors.grey,
                fontSize: width < 700 ? width / 35 : width / 43,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

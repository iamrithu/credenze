import 'package:credenze/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../const/global_colors.dart';
import '../../../../models/installation-employee-model.dart';

class CustomAddEmployee extends ConsumerStatefulWidget {
  final String token;
  final int id;
  final String date;
  final List<InstallationEmployeeModel> selectedlist;
  final Function onclick;

  const CustomAddEmployee({
    Key? key,
    required this.selectedlist,
    required this.onclick,
    required this.token,
    required this.id,
    required this.date,
  }) : super(key: key);

  @override
  _CustomAddEmployeeState createState() => _CustomAddEmployeeState();
}

class _CustomAddEmployeeState extends ConsumerState<CustomAddEmployee> {
  List<InstallationEmployeeModel> list = [];

  List<InstallationEmployeeModel> selectedEmployee = [];

  @override
  void initState() {
    Api().workParticipants(widget.token, widget.id, widget.date).then((value) {
      setState(() {
        list = value;
      });
    });
    super.initState();
    setState(() {
      selectedEmployee = widget.selectedlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    bool isActive(data) {
      if (selectedEmployee.contains(data)) {
        return true;
      } else {
        return false;
      }
    }

    return AlertDialog(
      title: Container(
        child: Text(
          "Participants",
          style: GoogleFonts.ptSans(
              color: GlobalColors.black,
              fontSize: width < 500 ? width / 25 : width / 35),
        ),
      ),
      content: Container(
          width: width,
          height: height * .3,
          child: Container(
            child: Column(
              children: [
                for (var i = 0; i < list.length; i++)
                  Card(
                    child: Container(
                      width: width,
                      height: height * 0.05,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: isActive(list[i]),
                            onChanged: (bool? value) {
                              if (value!) {
                                setState(() {
                                  selectedEmployee.add(list[i]);
                                  selectedEmployee.toSet().toList();
                                });
                              } else {
                                setState(() {
                                  selectedEmployee.toSet().toList();
                                  selectedEmployee.remove(list[i]);
                                });
                              }

                              widget.onclick(value, list[i]);
                            },
                          ),
                          Text(
                            "${list[i].name}",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize:
                                    width < 500 ? width / 25 : width / 35),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          )),
    );
  }
}

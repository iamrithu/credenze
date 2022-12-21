import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/global_colors.dart';
import 'widgets/lead_custom_input.dart';
import 'widgets/lead_custom_lable.dart';

const List<String> Salutation = <String>[
  'Mr',
  'Mrs',
  'Miss',
  'Dr',
  'sir',
  'Madam'
];
const List<String> Status = <String>[
  'Pending',
  'Inprocess',
  'Converted',
  'Not Intrested'
];
const List<String> LeadSource = [
  "Email",
  "Google",
  "Facebook",
  "Friend",
  "Direct Visit",
  "Tv ad",
  "Customer Referral",
];
const List<String> LeadCategory = [
  "Referral",
  "Zoho Source",
  "B2B",
];
const List<String> LeadAgend = [
  "",
  "Rithi",
  "Victor",
  "Aeron",
];
List<String> allowFolowUp = ["Yes", "No"];

class LeadAddingScreen extends StatefulWidget {
  const LeadAddingScreen({Key? key}) : super(key: key);

  @override
  _LeadAddingScreenState createState() => _LeadAddingScreenState();
}

class _LeadAddingScreenState extends State<LeadAddingScreen> {
  final List<bool> _allowFollowUp = <bool>[
    true,
    false,
  ];
  String _leadSource = LeadSource[0];
  String _salutation = Salutation[0];
  String _status = Status[0];
  String _leadCategory = LeadCategory[0];
  String _leadAgend = LeadAgend[0];
  String _allowFollowUpValue = "yes";
  String _country = "";
  String? _state = "";
  String? _city = "";
  late TextEditingController _leadNameController = TextEditingController();
  late TextEditingController _leadEmailController = TextEditingController();
  late TextEditingController _leadMobileNoController = TextEditingController();
  late TextEditingController _leadValueController = TextEditingController();
  late TextEditingController _leadNotesController = TextEditingController();
  late TextEditingController _companyNameController = TextEditingController();
  late TextEditingController _companyWebsiteController =
      TextEditingController();
  late TextEditingController _companyOfficeNoController =
      TextEditingController();
  late TextEditingController _companyPostalCodeController =
      TextEditingController();
  late TextEditingController _companyAddressController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            print(_salutation.toString() +
                " " +
                _leadNameController.text.toString());
            print(_status.toString());
            print(_allowFollowUpValue.toString());
            print(_country.toString());
            print(_city!.toString());
            print(_state!.toString());
            print(_leadEmailController.text.toString());
            print(_leadMobileNoController.text.toString());
            print(_leadValueController.text.toString());
            print(_leadNotesController.text.toString());
            print(_companyNameController.text.toString());
            print(_companyWebsiteController.text.toString());
            print(_companyOfficeNoController.text.toString());
            print(_companyPostalCodeController.text.toString());
            print(_companyAddressController.text.toString());
          },
          icon: Icon(
            Icons.add,
            color: GlobalColors.white,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalColors.themeColor,
            elevation: 20,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          label: Text(
            "Add Lead",
            style: GoogleFonts.abel(
                color: GlobalColors.white,
                fontSize: width < 700 ? width / 28 : width / 45,
                fontWeight: FontWeight.w400,
                letterSpacing: 0),
          ),
        ),
        body: Container(
          width: width,
          height: height * 0.7,
          padding: EdgeInsets.all(6),
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.4,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.01, vertical: height * 0.02),
                    child: Text(
                      "Lead Deatails",
                      style: GoogleFonts.abel(
                          color: GlobalColors.themeColor,
                          fontSize: width < 700 ? width / 20 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  LeadCustomLable(
                    lable: "Lead Name",
                    start: "*",
                  )
                ],
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.3,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2),
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        value: _salutation,
                        underline: Text(""),
                        isExpanded: false,
                        autofocus: true,
                        //menuMaxHeight: height * 0.2,
                        icon: Icon(Icons.arrow_downward,
                            color: GlobalColors.themeColor),
                        onChanged: (String? value) {
                          setState(() {
                            _salutation = value!;
                          });
                        },
                        items: Salutation.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.abel(
                                color: GlobalColors.themeColor2,
                                fontSize: width < 700 ? width / 28 : width / 47,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    LeadCustomInput(
                      lable: "Lead Name",
                      controller: _leadNameController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Lead Email",
                      start: "*",
                    ),
                    LeadCustomInput(
                      lable: "Lead Email",
                      controller: _leadEmailController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Mobiel No",
                      start: "*",
                    ),
                    LeadCustomInput(
                      lable: "e.g : 111111111",
                      controller: _leadMobileNoController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Lead Value",
                      start: "*",
                    ),
                    LeadCustomInput(
                      lable: "Lead Value",
                      controller: _leadValueController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Lead Agend",
                      start: "*",
                    ),
                    Container(
                      width: width * 0.65,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2),
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        value: _leadAgend,
                        underline: Text(""),
                        isExpanded: true,
                        autofocus: true,
                        //menuMaxHeight: height * 0.2,
                        icon: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Icon(Icons.arrow_downward,
                              color: GlobalColors.themeColor),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _leadAgend = value!;
                          });
                        },
                        items: LeadAgend.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: Text(
                                value,
                                style: GoogleFonts.abel(
                                  color: GlobalColors.themeColor2,
                                  fontSize:
                                      width < 700 ? width / 28 : width / 47,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Lead Source",
                      start: "*",
                    ),
                    Container(
                      width: width * 0.65,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2),
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        value: _leadSource,
                        underline: Text(""),
                        isExpanded: true,
                        autofocus: true,
                        //menuMaxHeight: height * 0.2,
                        icon: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Icon(Icons.arrow_downward,
                              color: GlobalColors.themeColor),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _leadSource = value!;
                          });
                        },
                        items: LeadSource.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: Text(
                                value,
                                style: GoogleFonts.abel(
                                  color: GlobalColors.themeColor2,
                                  fontSize:
                                      width < 700 ? width / 28 : width / 47,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Lead Category",
                      start: "*",
                    ),
                    Container(
                      width: width * 0.65,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2),
                      ),
                      child: DropdownButton<String>(
                        value: _leadCategory,
                        underline: Text(""),
                        isExpanded: true,
                        autofocus: true,
                        //menuMaxHeight: height * 0.2,
                        icon: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Icon(Icons.arrow_downward,
                              color: GlobalColors.themeColor),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _leadCategory = value!;
                          });
                        },
                        items: LeadCategory.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: Text(
                                value,
                                style: GoogleFonts.abel(
                                  color: GlobalColors.themeColor2,
                                  fontSize:
                                      width < 700 ? width / 28 : width / 47,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "AllowFollowUp",
                      start: "*",
                    ),
                    Container(
                      width: width * 0.6,
                      alignment: AlignmentDirectional.center,
                      child: ToggleButtons(
                        direction: Axis.horizontal,
                        onPressed: (int index) {
                          setState(() {
                            // The button that is tapped is set to true, and the others to false.
                            for (int i = 0; i < _allowFollowUp.length; i++) {
                              _allowFollowUp[i] = i == index;
                            }
                            allowFolowUp[index];
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.red[700],
                        selectedColor: Colors.white,
                        fillColor: GlobalColors.themeColor,
                        color: GlobalColors.themeColor2,
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 80.0,
                        ),
                        isSelected: _allowFollowUp,
                        children: [Text("Yes"), Text("No")],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Status",
                      start: "*",
                    ),
                    Container(
                      width: width * 0.65,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: GlobalColors.themeColor2),
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        value: _status,
                        underline: Text(""),
                        isExpanded: true,
                        autofocus: true,
                        //menuMaxHeight: height * 0.2,
                        icon: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: Icon(Icons.arrow_downward,
                              color: GlobalColors.themeColor),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                        items: Status.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              child: Text(
                                value,
                                style: GoogleFonts.abel(
                                  color: GlobalColors.themeColor2,
                                  fontSize:
                                      width < 700 ? width / 28 : width / 47,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      width: width * 0.97,
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      decoration: BoxDecoration(
                          border: Border.all(color: GlobalColors.themeColor2),
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        controller: _leadNotesController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "    Notes.....",
                          hintStyle: GoogleFonts.abel(
                              color: GlobalColors.themeColor2,
                              fontSize: width < 700 ? width / 28 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                        ),
                        maxLines: 5,
                      )),
                ],
              ),
              Divider(
                color: GlobalColors.themeColor2,
                height: height * 0.05,
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    width: width * 0.4,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.01, vertical: height * 0.02),
                    child: Text(
                      "Company Deatails",
                      style: GoogleFonts.abel(
                          color: GlobalColors.themeColor,
                          fontSize: width < 700 ? width / 20 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Company Name",
                      start: null,
                    ),
                    LeadCustomInput(
                      lable: "Company Name",
                      controller: _companyNameController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Website",
                      start: null,
                    ),
                    LeadCustomInput(
                      lable: "e.g : https://www.example.com",
                      controller: _companyWebsiteController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Office No",
                      start: null,
                    ),
                    LeadCustomInput(
                      lable: "office-no",
                      controller: _companyOfficeNoController,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                margin: EdgeInsets.only(top: 5),
                child: CSCPicker(
                  // dropdownItemStyle: GoogleFonts.abel(
                  //     color: GlobalColors.black,
                  //     fontSize: width < 700 ? width / 28 : width / 45,
                  //     fontWeight: FontWeight.w400,
                  //     letterSpacing: 0),
                  // selectedItemStyle: GoogleFonts.abel(
                  //     color: GlobalColors.black,
                  //     fontSize: width < 700 ? width / 28 : width / 45,
                  //     fontWeight: FontWeight.w400,
                  //     letterSpacing: 0),
                  searchBarRadius: 100,
                  onCountryChanged: (value) {
                    setState(() {
                      _country = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      _state = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      _city = value;
                    });
                  },
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LeadCustomLable(
                      lable: "Postal Code",
                      start: null,
                    ),
                    LeadCustomInput(
                      lable: "postal-code ",
                      controller: _companyPostalCodeController,
                    ),
                  ],
                ),
              ),
              Container(
                  width: width * 0.97,
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  decoration: BoxDecoration(
                      border: Border.all(color: GlobalColors.themeColor2),
                      borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    controller: _companyAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "   Address",
                      hintStyle: GoogleFonts.abel(
                          color: GlobalColors.themeColor2,
                          fontSize: width < 700 ? width / 28 : width / 45,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0),
                    ),
                    maxLines: 5,
                  )),
            ],
          ),
        ));
  }
}

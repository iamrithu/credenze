import 'package:credenze/apis/api.dart';
import 'package:credenze/const/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../../models/installation-employee-model.dart';
import '../../../../river-pod/riverpod_provider.dart';
import '../../../instalation-screen/tabs/widget/custom-add-employee.dart';
import 'custom-add-employe.dart';

class ServiceAddWorkUpdate extends ConsumerStatefulWidget {
  final Function onclick;
  ServiceAddWorkUpdate({
    Key? key,
    required this.onclick,
  }) : super(key: key);

  @override
  _ServiceAddWorkUpdateState createState() => _ServiceAddWorkUpdateState();
}

class _ServiceAddWorkUpdateState extends ConsumerState<ServiceAddWorkUpdate> {
  final TextEditingController _controller = TextEditingController();
  DateTime workUpdateDate = DateTime.now();
  List<InstallationEmployeeModel> selectedEmployee = [];
  List<InstallationEmployeeModel> demo = [];
  bool serialVisible = true;
  var selectedCheckbox = [];
  String workTask = "Select Task";
  String notes = "";
  int is_removable_task = 0;
  int removal_qty = 0;
  int workTaskId = 0;
  var product = {};
  var productList = [];
  var OtherProductList = [];

  var serialnosList = [];
  var selectedProduct = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    onSelect(bool value, InstallationEmployeeModel list) {
      if (value) {
        setState(() {
          selectedEmployee.add(list);
          selectedEmployee = selectedEmployee.toSet().toList();
        });
      } else {
        setState(() {
          selectedEmployee.remove(list);
          selectedEmployee = selectedEmployee.toSet().toList();
        });
      }
    }

    Color getColors(value, dataList) {
      var data = serialnosList.firstWhere(
          (element) => element["productId"] == dataList, orElse: () {
        return null;
      });
      if (data == null) {
        return GlobalColors.white;
      }

      if (data["sNo"].contains(value)) {
        return GlobalColors.themeColor;
      }

      return GlobalColors.white;
    }

    int getUsedserialNo(dataList) {
      var data = serialnosList.firstWhere(
          (element) => element["productId"] == dataList, orElse: () {
        return null;
      });
      if (data == null) {
        return 0;
      }

      return data["sNo"].length;
    }

    return Container(
      width: width,
      height: height * 0.8,
      decoration:
          BoxDecoration(border: Border.all(color: GlobalColors.themeColor2)),
      child: Column(
        children: [
          Container(
            width: width,
            color: GlobalColors.themeColor,
            child: Center(
              child: Text(
                "Work Update",
                style: GoogleFonts.ptSans(
                    color: GlobalColors.white,
                    fontSize: width < 700 ? width / 28 : width / 45,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              ),
            ),
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    constraints: BoxConstraints(
                        minWidth: width, minHeight: height * 0.05),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Date",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Container(
                          width: width * 0.05,
                          child: Text(
                            ":",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    currentDate: workUpdateDate)
                                .then((value) {
                              setState(() {
                                workUpdateDate = value!;
                              });
                            });
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: width * 0.55,
                              height: height * 0.04,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalColors.themeColor2),
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              child: Text(
                                "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor2,
                                    fontSize:
                                        width < 700 ? width / 30 : width / 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    constraints: BoxConstraints(
                        minWidth: width, minHeight: height * 0.05),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Participants *",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Container(
                          width: width * 0.05,
                          child: Text(
                            ":",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Container(
                          width: width * 0.4,
                          alignment: Alignment.center,
                          child: selectedEmployee.isEmpty
                              ? Center(
                                  child: Card(
                                    elevation: 5,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      margin: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 227, 225, 225),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "Add Partcipant",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.black,
                                            fontSize: width < 700
                                                ? width / 34
                                                : width / 45,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    for (var i = 0;
                                        i < selectedEmployee.length;
                                        i++)
                                      Row(
                                        children: [
                                          Card(
                                            elevation: 5,
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: GlobalColors
                                                          .themeColor),
                                                  borderRadius:
                                                      BorderRadius.circular(2)),
                                              child: Text(
                                                "${selectedEmployee[i].name}",
                                                style: GoogleFonts.ptSans(
                                                    color:
                                                        GlobalColors.themeColor,
                                                    fontSize: width < 700
                                                        ? width / 36
                                                        : width / 45,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                        ),
                        Container(
                          width: width * 0.15,
                          height: height * 0.05,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: GlobalColors.themeColor2)),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                selectedEmployee = [];
                              });
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return ServiceCustomAddEmployee(
                                    token: ref.watch(newToken)!,
                                    id: ref.watch(ServiceId),
                                    date:
                                        "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
                                    onclick: onSelect,
                                    selectedlist: selectedEmployee,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    constraints: BoxConstraints(
                        minWidth: width, minHeight: height * 0.05),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Task *",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Container(
                          width: width * 0.05,
                          child: Text(
                            ":",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Api()
                                .serviceWorkTaskList(
                                    ref.watch(newToken), ref.watch(ServiceId))
                                .then((value) {
                              // print(value.toString());
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Container(
                                      child: Text(
                                        "Task :",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.themeColor,
                                            fontSize: width < 500
                                                ? width / 25
                                                : width / 35),
                                      ),
                                    ),
                                    content: Container(
                                      width: width,
                                      height: height * 0.3,
                                      child: ListView(
                                        children: [
                                          for (var i = 0; i < value.length; i++)
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  productList = [];
                                                  OtherProductList = [];
                                                  selectedCheckbox = [];
                                                });
                                                setState(() {
                                                  workTask = value[i]
                                                      ["category"]["name"];
                                                  workTaskId = value[i]["id"];
                                                  is_removable_task =
                                                      value[i]["is_removable"];
                                                  removal_qty = value[i]
                                                      ["removeable_count"];
                                                  _controller.text = "";
                                                });
                                                Api()
                                                    .serviceWorkProductList(
                                                        ref.watch(newToken),
                                                        ref.watch(ServiceId),
                                                        workTaskId)
                                                    .then((value) {
                                                  setState(() {
                                                    product = value;
                                                  });

                                                  if (product["task_details"]
                                                          ["is_removable"] ==
                                                      0) {
                                                    product["task_products"]
                                                        .forEach((v, k) {
                                                      product["task_products"]
                                                          [v.toString()];

                                                      setState(() {
                                                        productList.add(product[
                                                                "task_products"]
                                                            [v.toString()]);

                                                        productList
                                                            .toSet()
                                                            .toList();
                                                      });
                                                    });

                                                    product["other_products"]
                                                        .forEach((v, k) {
                                                      product["other_products"]
                                                          [v.toString()];

                                                      setState(() {
                                                        OtherProductList.add(
                                                            product["other_products"]
                                                                [v.toString()]);

                                                        OtherProductList.toSet()
                                                            .toList();
                                                      });
                                                    });
                                                  } else {
                                                    productList = [];
                                                    OtherProductList = [];
                                                  }
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  width: width,
                                                  height: height * 0.05,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      border: Border.all(
                                                          color: GlobalColors
                                                              .themeColor2)),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${value[i]["category"]["name"]}",
                                                        style: GoogleFonts.ptSans(
                                                            color: GlobalColors
                                                                .themeColor2,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: width <
                                                                    500
                                                                ? width / 35
                                                                : width / 35),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: width * 0.5,
                              constraints:
                                  BoxConstraints(minHeight: height * 0.04),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalColors.themeColor2),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(
                                workTask,
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor2,
                                    fontSize:
                                        width < 700 ? width / 30 : width / 45,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Center(child: Text("")))
                      ],
                    ),
                  ),
                  if (is_removable_task == 1)
                    Column(
                      children: [
                        Divider(
                          thickness: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 3),
                          constraints: BoxConstraints(
                              minWidth: width, minHeight: height * 0.05),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Text(
                                      "Removeable Count",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  )),
                              Card(
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      "${product["removable_pending"]}",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 700
                                              ? width / 30
                                              : width / 45,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "Used Count",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.black,
                                            fontSize: width < 700
                                                ? width / 30
                                                : width / 45,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: TextField(
                                      controller: _controller,
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.black,
                                          fontSize: width < 500
                                              ? width / 35
                                              : width / 35),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      onChanged: (value) {
                                        setState(() {
                                          removal_qty = int.parse(value);
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (productList.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 1),
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Products",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 500
                                            ? width / 30
                                            : width / 45),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  for (var i = 0; i < productList.length; i++)
                    Card(
                      elevation: 1,
                      child: Column(
                        children: [
                          Card(
                            elevation: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Checkbox(
                                            activeColor:
                                                GlobalColors.themeColor,
                                            checkColor: GlobalColors.white,
                                            value: selectedCheckbox
                                                .contains(productList[i]),
                                            onChanged: (bool? value) {
                                              if (value!) {
                                                var data = productList[i];
                                                setState(() {
                                                  selectedCheckbox.add(data);
                                                });
                                              } else {
                                                var data = selectedCheckbox
                                                    .firstWhere(
                                                        (element) =>
                                                            element[
                                                                "item_id"] ==
                                                            productList[i]
                                                                ["item_id"],
                                                        orElse: () {
                                                  return null;
                                                });
                                                data["used_quantity"] = "";

                                                setState(() {
                                                  selectedCheckbox
                                                      .remove(productList[i]);
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          child: Text(
                                            "${productList[i]["item_name"]}",
                                            style: GoogleFonts.ptSans(
                                                color: GlobalColors.black,
                                                fontSize: width < 500
                                                    ? width / 35
                                                    : width / 35),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${productList[i]["unit_name"]}",
                                            style: GoogleFonts.ptSans(
                                                color: GlobalColors.black,
                                                fontSize: width < 500
                                                    ? width / 35
                                                    : width / 35),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${productList[i]["pending_quantity"]}",
                                            style: GoogleFonts.ptSans(
                                                color: GlobalColors.black,
                                                fontSize: width < 500
                                                    ? width / 35
                                                    : width / 35),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (selectedCheckbox.contains(productList[i]))
                                    if (productList[i]["serial_no"] != null)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                "S No:",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 35),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Wrap(
                                              children: [
                                                Visibility(
                                                  visible: serialVisible,
                                                  child: Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        productList[i]
                                                                ["serial_no"]
                                                            .toString(),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  if (selectedCheckbox.contains(productList[i]))
                                    if (productList[i]["serialnos"] != null)
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                "S.NO:",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 35),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Wrap(
                                              children: [
                                                for (var s = 0;
                                                    s <
                                                        productList[i]
                                                                ["serialnos"]
                                                            .length;
                                                    s++)
                                                  InkWell(
                                                    onTap: () {
                                                      if (serialnosList
                                                          .isEmpty) {
                                                        setState(() {
                                                          serialnosList.add({
                                                            "productId":
                                                                productList[i]
                                                                    ["item_id"],
                                                            "sNo": [
                                                              productList[i][
                                                                  "serialnos"][s]
                                                            ]
                                                          });
                                                        });
                                                      }

                                                      var data = serialnosList
                                                          .firstWhere(
                                                              (element) =>
                                                                  element[
                                                                      "productId"] ==
                                                                  productList[i]
                                                                      [
                                                                      "item_id"],
                                                              orElse: () {
                                                        return null;
                                                      });
                                                      if (data == null) {
                                                        setState(() {
                                                          serialnosList.add({
                                                            "productId":
                                                                productList[i]
                                                                    ["item_id"],
                                                            "sNo": [
                                                              productList[i][
                                                                  "serialnos"][s]
                                                            ]
                                                          });
                                                        });
                                                      } else {
                                                        if (data["sNo"].contains(
                                                            productList[i][
                                                                    "serialnos"]
                                                                [s])) {
                                                          data["sNo"].remove(
                                                              productList[i][
                                                                      "serialnos"]
                                                                  [s]);
                                                        } else {
                                                          data["sNo"].add(
                                                              productList[i][
                                                                      "serialnos"]
                                                                  [s]);
                                                        }

                                                        if (data["sNo"].length <
                                                            1) {
                                                          serialnosList.remove({
                                                            "productId":
                                                                productList[i]
                                                                    ["item_id"],
                                                            "sNo": []
                                                          });
                                                        }
                                                        var getData = selectedCheckbox
                                                            .firstWhere(
                                                                (element) =>
                                                                    element[
                                                                        "item_id"] ==
                                                                    productList[
                                                                            i][
                                                                        "item_id"],
                                                                orElse: () {
                                                          return null;
                                                        });
                                                        getData["used_serialNos"] =
                                                            data["sNo"];

                                                        getColors(
                                                            productList[i][
                                                                "serialnos"][s],
                                                            productList[i]
                                                                ["item_id"]);

                                                        setState(() {
                                                          serialVisible =
                                                              !serialVisible;
                                                        });
                                                        setState(() {
                                                          serialVisible =
                                                              !serialVisible;
                                                        });
                                                      }
                                                    },
                                                    child: Visibility(
                                                      visible: serialVisible,
                                                      child: Card(
                                                        color: getColors(
                                                            productList[i][
                                                                "serialnos"][s],
                                                            productList[i]
                                                                ["item_id"]),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                            productList[i][
                                                                    "serialnos"][s]
                                                                .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                  if (selectedCheckbox.contains(productList[i]))
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(""),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "Used Quantity",
                                              style: GoogleFonts.ptSans(
                                                  color:
                                                      GlobalColors.themeColor2,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: productList[i]
                                                        ["serial_no"] !=
                                                    null
                                                ? Container(
                                                    constraints: BoxConstraints(
                                                        minHeight: 50,
                                                        minWidth: 100),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: GlobalColors
                                                                .themeColor,
                                                            width: 2)),
                                                    child: Center(
                                                        child: Text(productList[
                                                                    i][
                                                                "pending_quantity"]
                                                            .toString())),
                                                  )
                                                : productList[i]["serialnos"] !=
                                                        null
                                                    ? Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                minHeight: 50,
                                                                minWidth: 100),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            border: Border.all(
                                                                color: GlobalColors
                                                                    .themeColor,
                                                                width: 2)),
                                                        child: Center(
                                                            child: Text(getUsedserialNo(
                                                                    productList[
                                                                            i][
                                                                        "item_id"])
                                                                .toString())),
                                                      )
                                                    : TextFormField(
                                                        initialValue: selectedCheckbox
                                                            .firstWhere(
                                                                (element) =>
                                                                    element[
                                                                        "item_id"] ==
                                                                    productList[
                                                                            i][
                                                                        "item_id"],
                                                                orElse: () {
                                                          return null;
                                                        })["used_quantity"],
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .black,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        35),
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4))),
                                                        onChanged: (value) {
                                                          var data = selectedCheckbox
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element[
                                                                          "item_id"] ==
                                                                      productList[
                                                                              i]
                                                                          [
                                                                          "item_id"],
                                                                  orElse: () {
                                                            return null;
                                                          });
                                                          data["used_quantity"] =
                                                              value;

                                                          // print(data.toString());
                                                          // do something
                                                        },
                                                      ),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (OtherProductList.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 1),
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Other Products",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.themeColor,
                                        fontSize: width < 500
                                            ? width / 30
                                            : width / 45),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (OtherProductList.isNotEmpty)
                    Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          for (var i = 0; i < OtherProductList.length; i++)
                            Card(
                              elevation: 3,
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Checkbox(
                                              activeColor:
                                                  GlobalColors.themeColor,
                                              checkColor: GlobalColors.white,
                                              value: selectedCheckbox.contains(
                                                  OtherProductList[i]),
                                              onChanged: (bool? value) {
                                                if (value!) {
                                                  setState(() {
                                                    selectedCheckbox.add(
                                                        OtherProductList[i]);
                                                  });
                                                } else {
                                                  var data = selectedCheckbox
                                                      .firstWhere(
                                                          (element) =>
                                                              element[
                                                                  "item_id"] ==
                                                              OtherProductList[
                                                                  i]["item_id"],
                                                          orElse: () {
                                                    return null;
                                                  });
                                                  data["used_quantity"] = "";

                                                  setState(() {
                                                    selectedCheckbox.remove(
                                                        OtherProductList[i]);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            child: Text(
                                              "${OtherProductList[i]["item_name"]}",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${OtherProductList[i]["unit_name"]}",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${OtherProductList[i]["pending_quantity"]}",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (selectedCheckbox
                                        .contains(OtherProductList[i]))
                                      if (OtherProductList[i]["serial_no"] !=
                                          null)
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  "S No:",
                                                  style: GoogleFonts.ptSans(
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      fontSize: width < 500
                                                          ? width / 35
                                                          : width / 35),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Wrap(
                                                children: [
                                                  Visibility(
                                                    visible: serialVisible,
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Text(
                                                          OtherProductList[i]
                                                                  ["serial_no"]
                                                              .toString(),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    if (selectedCheckbox
                                        .contains(OtherProductList[i]))
                                      if (OtherProductList[i]["serialnos"] !=
                                          null)
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  "S No:",
                                                  style: GoogleFonts.ptSans(
                                                      color: GlobalColors
                                                          .themeColor2,
                                                      fontSize: width < 500
                                                          ? width / 35
                                                          : width / 35),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Wrap(
                                                children: [
                                                  for (var s = 0;
                                                      s <
                                                          OtherProductList[i]
                                                                  ["serialnos"]
                                                              .length;
                                                      s++)
                                                    InkWell(
                                                      onTap: () {
                                                        if (serialnosList
                                                            .isEmpty) {
                                                          setState(() {
                                                            serialnosList.add({
                                                              "productId":
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"],
                                                              "sNo": [
                                                                OtherProductList[
                                                                        i][
                                                                    "serialnos"][s]
                                                              ]
                                                            });
                                                          });
                                                        }
                                                        var data = serialnosList
                                                            .firstWhere(
                                                                (element) =>
                                                                    element[
                                                                        "productId"] ==
                                                                    OtherProductList[
                                                                            i]
                                                                        [
                                                                        "item_id"],
                                                                orElse: () {
                                                          return null;
                                                        });
                                                        if (data == null) {
                                                          setState(() {
                                                            serialnosList.add({
                                                              "productId":
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"],
                                                              "sNo": [
                                                                OtherProductList[
                                                                        i][
                                                                    "serialnos"][s]
                                                              ]
                                                            });
                                                          });
                                                        } else {
                                                          if (data["sNo"].contains(
                                                              OtherProductList[
                                                                          i][
                                                                      "serialnos"]
                                                                  [s])) {
                                                            data["sNo"].remove(
                                                                OtherProductList[
                                                                            i][
                                                                        "serialnos"]
                                                                    [s]);
                                                          } else {
                                                            data["sNo"].add(
                                                                OtherProductList[
                                                                            i][
                                                                        "serialnos"]
                                                                    [s]);
                                                          }

                                                          if (data["sNo"]
                                                                  .length <
                                                              1) {
                                                            serialnosList
                                                                .remove({
                                                              "productId":
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"],
                                                              "sNo": []
                                                            });
                                                          }
                                                          var getData = selectedCheckbox.firstWhere(
                                                              (element) =>
                                                                  element[
                                                                      "item_id"] ==
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"],
                                                              orElse: () {
                                                            return null;
                                                          });
                                                          getData["used_serialNos"] =
                                                              data["sNo"];

                                                          getColors(
                                                              OtherProductList[
                                                                          i][
                                                                      "serialnos"]
                                                                  [s],
                                                              OtherProductList[
                                                                      i]
                                                                  ["item_id"]);

                                                          setState(() {
                                                            serialVisible =
                                                                !serialVisible;
                                                          });
                                                          setState(() {
                                                            serialVisible =
                                                                !serialVisible;
                                                          });
                                                        }
                                                      },
                                                      child: Visibility(
                                                        visible: serialVisible,
                                                        child: Card(
                                                          color: getColors(
                                                              OtherProductList[
                                                                          i][
                                                                      "serialnos"]
                                                                  [s],
                                                              OtherProductList[
                                                                      i]
                                                                  ["item_id"]),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Text(
                                                              OtherProductList[
                                                                          i][
                                                                      "serialnos"][s]
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                    if (selectedCheckbox
                                        .contains(OtherProductList[i]))
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(""),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Used Quantity",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors
                                                        .themeColor2,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 35),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: OtherProductList[i]
                                                          ["serialnos"] !=
                                                      null
                                                  ? Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minHeight: 50,
                                                              minWidth: 100),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              color: GlobalColors
                                                                  .themeColor,
                                                              width: 2)),
                                                      child: Center(
                                                          child: Text(getUsedserialNo(
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"])
                                                              .toString())),
                                                    )
                                                  : TextFormField(
                                                      initialValue: selectedCheckbox
                                                          .firstWhere(
                                                              (element) =>
                                                                  element[
                                                                      "item_id"] ==
                                                                  OtherProductList[
                                                                          i][
                                                                      "item_id"],
                                                              orElse: () {
                                                        return null;
                                                      })["used_quantity"],
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .black,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 35),
                                                      decoration: InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4))),
                                                      onChanged: (value) {
                                                        var data = selectedCheckbox
                                                            .firstWhere(
                                                                (element) =>
                                                                    element[
                                                                        "item_id"] ==
                                                                    OtherProductList[
                                                                            i]
                                                                        [
                                                                        "item_id"],
                                                                orElse: () {
                                                          return null;
                                                        });
                                                        data["used_quantity"] =
                                                            value;

                                                        // do something
                                                      },
                                                    ),
                                            )
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Divider(
                    thickness: 2,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    constraints: BoxConstraints(
                        minWidth: width, minHeight: height * 0.05),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text(
                            "Notes",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Container(
                          width: width * 0.05,
                          child: Text(
                            ":",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.black,
                                fontSize: width < 700 ? width / 30 : width / 45,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                                minLines: 2,
                                maxLines: 4,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4))),
                                onChanged: (value) {
                                  setState(() {
                                    notes = value.trim();
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedEmployee.length < 1) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Add one or more participants",
                          autoCloseDuration: null);

                      return null;
                    }
                    if (workTask.isEmpty || workTask == "Select Task") {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "Select task",
                          autoCloseDuration: null);

                      return null;
                    }
                    if (selectedCheckbox.length < 1 && is_removable_task != 1) {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: "The product field is required",
                          autoCloseDuration: null);

                      return null;
                    }

                    for (var i = 0; i < selectedCheckbox.length; i++) {
                      if (selectedCheckbox[i]["enable_serial_no"] == 0) {
                        if (selectedCheckbox[i].containsKey('used_quantity') ==
                            false) {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title:
                                  "Enter quantity of ${selectedCheckbox[i]["item_name"]}",
                              autoCloseDuration: null);

                          return null;
                        } else {
                          if (selectedCheckbox[i]["used_quantity"] == "" ||
                              selectedCheckbox[i]["used_quantity"] == "0") {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title:
                                    "Please enter Valid Quantity for ${selectedCheckbox[i]["item_name"]}",
                                autoCloseDuration: null);

                            return null;
                          }
                        }
                      } else {
                        if (selectedCheckbox[i]["serial_no"] == null) {
                          if (selectedCheckbox[i]["serialnos"].length < 1) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title:
                                    " ${selectedCheckbox[i]["item_name"]} does not have any items.",
                                autoCloseDuration: null);

                            return null;
                          }
                          if (selectedCheckbox[i]["used_serialNos"].length <
                              1) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title:
                                    "Enter quantity of ${selectedCheckbox[i]["item_name"]}",
                                autoCloseDuration: null);

                            return null;
                          }
                        }
                      }
                    }
                    // if (is_removable_task.toString() == "1") {
                    //   if (removal_qty == 0) {
                    //     QuickAlert.show(
                    //         context: context,
                    //         type: QuickAlertType.error,
                    //         title:
                    //             "Completed Quantity is not exceeds the pending Quantity",
                    //         autoCloseDuration: null);

                    //     return null;
                    //   }
                    // }
                    Api()
                        .ServiceWorkUpdateAdd(
                            ref.watch(newToken),
                            ref.watch(ServiceId),
                            workTaskId,
                            "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
                            selectedEmployee,
                            notes,
                            ref.watch(inChargeId),
                            is_removable_task,
                            removal_qty,
                            selectedCheckbox)
                        .then((value) {
                      if (value.data["success"]) {
                        widget.onclick();

                        Navigator.pop(context);
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: "${value.data["message"]}",
                            autoCloseDuration: Duration(seconds: 2));
                      } else {
                        if (value.statusCode.toString() == "422" ||
                            value.statusCode.toString() == "500") {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: "${value.data["error"]["message"]}",
                              autoCloseDuration: null);

                          return null;
                        }
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: "${value.data["message"]}",
                            autoCloseDuration: null);
                      }
                    });
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          )
          //           Container(
          //             width: width,
          //             color: GlobalColors.themeColor,
          //             child: Center(
          //               child: Text(
          //                 "Work Update",
          //                 style: GoogleFonts.ptSans(
          //                     color: GlobalColors.white,
          //                     fontSize: width < 700 ? width / 28 : width / 45,
          //                     fontWeight: FontWeight.w600,
          //                     letterSpacing: 0),
          //               ),
          //             ),
          //             height: 40,
          //           ),
          //           Expanded(
          //             child: Column(
          //               children: [
          //                 Container(
          //                   margin: EdgeInsets.only(bottom: 3),
          //                   decoration: BoxDecoration(
          //                       border: Border(
          //                           bottom: BorderSide(
          //                               color: Color.fromARGB(255, 200, 196, 196),
          //                               width: 0.5))),
          //                   constraints: BoxConstraints(
          //                       minWidth: width, minHeight: height * 0.05),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                           child: Container(
          //                         child: Text(
          //                           "Date",
          //                           style: GoogleFonts.ptSans(
          //                               color: GlobalColors.black,
          //                               fontSize:
          //                                   width < 700 ? width / 30 : width / 45,
          //                               fontWeight: FontWeight.w400,
          //                               letterSpacing: 0),
          //                         ),
          //                       )),
          //                       Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                           alignment: Alignment.center,
          //                           child: Text(
          //                             "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
          //                             style: GoogleFonts.ptSans(
          //                                 color: GlobalColors.themeColor,
          //                                 fontSize:
          //                                     width < 700 ? width / 30 : width / 45,
          //                                 fontWeight: FontWeight.w400,
          //                                 letterSpacing: 0),
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: Container(
          //                           child: IconButton(
          //                             icon: Icon(Icons.calendar_month),
          //                             onPressed: () {
          //                               showDatePicker(
          //                                       context: context,
          //                                       initialDate: DateTime.now(),
          //                                       firstDate: DateTime(2000),
          //                                       lastDate: DateTime(2100),
          //                                       currentDate: workUpdateDate)
          //                                   .then((value) {
          //                                 setState(() {
          //                                   workUpdateDate = value!;
          //                                 });
          //                               });
          //                             },
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.only(bottom: 3),
          //                   decoration: BoxDecoration(
          //                       border: Border(
          //                           bottom: BorderSide(
          //                               color: Color.fromARGB(255, 200, 196, 196),
          //                               width: 0.5))),
          //                   constraints: BoxConstraints(
          //                       minWidth: width, minHeight: height * 0.05),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                           child: Container(
          //                         child: Text(
          //                           "Participants *",
          //                           style: GoogleFonts.ptSans(
          //                               color: GlobalColors.black,
          //                               fontSize:
          //                                   width < 700 ? width / 30 : width / 45,
          //                               fontWeight: FontWeight.w400,
          //                               letterSpacing: 0),
          //                         ),
          //                       )),
          //                       Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                           alignment: Alignment.center,
          //                           child: Wrap(
          //                             spacing: 5,
          //                             children: [
          //                               for (var i = 0;
          //                                   i < selectedEmployee.length;
          //                                   i++)
          //                                 Chip(
          //                                   backgroundColor:
          //                                       Color.fromARGB(255, 249, 223, 223),
          //                                   shape: RoundedRectangleBorder(
          //                                     side: BorderSide(
          //                                         color: GlobalColors.themeColor),
          //                                     borderRadius: BorderRadius.circular(4),
          //                                   ),
          //                                   label: Text(
          //                                     "${selectedEmployee[i].name}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.themeColor,
          //                                         fontSize: width < 700
          //                                             ? width / 30
          //                                             : width / 45,
          //                                         fontWeight: FontWeight.w400,
          //                                         letterSpacing: 0),
          //                                   ),
          //                                 ),
          //                             ],
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(
          //                         child: Container(
          //                           child: IconButton(
          //                             icon: Icon(Icons.add),
          //                             onPressed: () {
          //                               setState(() {
          //                                 selectedEmployee = [];
          //                               });
          //                               showDialog<void>(
          //                                 context: context,
          //                                 barrierDismissible: true,
          //                                 builder: (context) {
          // return ServiceCustomAddEmployee(
          //   token: ref.watch(newToken)!,
          //   id: ref.watch(ServiceId),
          //   date:
          //       "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
          //   onclick: onSelect,
          //   selectedlist: selectedEmployee,
          // );
          //                                 },
          //                               );
          //                             },
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.only(bottom: 3),
          //                   decoration: BoxDecoration(
          //                       border: Border(
          //                           bottom: BorderSide(
          //                               color: Color.fromARGB(255, 200, 196, 196),
          //                               width: 0.5))),
          //                   constraints: BoxConstraints(
          //                       minWidth: width, minHeight: height * 0.05),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                           child: Container(
          //                         child: Text(
          //                           "Task *",
          //                           style: GoogleFonts.ptSans(
          //                               color: GlobalColors.black,
          //                               fontSize:
          //                                   width < 700 ? width / 30 : width / 45,
          //                               fontWeight: FontWeight.w400,
          //                               letterSpacing: 0),
          //                         ),
          //                       )),
          //                       Expanded(
          //                         flex: 2,
          //                         child: InkWell(
          //                           onTap: () {
          // Api()
          //     .serviceWorkTaskList(ref.watch(newToken),
          //         ref.watch(ServiceId))
          //                                 .then((value) {
          //                               showDialog<void>(
          //                                 context: context,
          //                                 barrierDismissible: true,
          //                                 builder: (context) {
          //                                   return AlertDialog(
          //                                     title: Container(
          //                                       child: Text(
          //                                         "Task",
          //                                         style: GoogleFonts.ptSans(
          //                                             color: GlobalColors.black,
          //                                             fontSize: width < 500
          //                                                 ? width / 25
          //                                                 : width / 35),
          //                                       ),
          //                                     ),
          //                                     content: Container(
          //                                       width: width,
          //                                       height: height * .3,
          //                                       child: ListView(
          //                                         children: [
          //                                           for (var i = 0;
          //                                               i < value.length;
          //                                               i++)
          //                                             InkWell(
          //                                               onTap: () {
          //                                                 setState(() {
          //                                                   productList = [];
          //                                                   OtherProductList = [];
          //                                                   selectedCheckbox = [];
          //                                                 });
          //                                                 setState(() {
          //                                                   workTask = value[i]
          //                                                       ["category"]["name"];
          //                                                   workTaskId =
          //                                                       value[i]["id"];
          //                                                   is_removable_task =
          //                                                       value[i]
          //                                                           ["is_removable"];
          //                                                   removal_qty = value[i]
          //                                                       ["removeable_count"];
          //                                                       _controller.text="";
          //                                                 });

          // Api()
          //     .serviceWorkProductList(
          //         ref.watch(newToken),
          //         ref.watch(
          //             ServiceId),
          //         workTaskId)
          //                                                     .then((value) {

          //                                                       print(value.toString());
          //                                                   setState(() {
          //                                                     product = value;
          //                                                   });
          //                                                   if (product["task_details"]
          //                                                           [
          //                                                           "is_removable"] ==
          //                                                       0) {
          //                                                     product["task_products"]
          //                                                         .forEach((v, k) {
          //                                                       product["task_products"]
          //                                                           [v.toString()];

          //                                                       setState(() {
          //                                                         productList.add(product[
          //                                                                 "task_products"]
          //                                                             [v.toString()]);

          //                                                         productList
          //                                                             .toSet()
          //                                                             .toList();
          //                                                       });
          //                                                     });

          //                                                     product["other_products"]
          //                                                         .forEach((v, k) {
          //                                                       product["other_products"]
          //                                                           [v.toString()];

          //                                                       setState(() {
          //                                                         OtherProductList
          //                                                             .add(product[
          //                                                                     "other_products"]
          //                                                                 [
          //                                                                 v.toString()]);

          //                                                         OtherProductList
          //                                                                 .toSet()
          //                                                             .toList();
          //                                                       });
          //                                                     });
          //                                                   } else {
          //                                                     productList = [];
          //                                                     OtherProductList = [];
          //                                                   }
          //                                                 });

          //                                                 Navigator.pop(context);
          //                                               },
          //                                               child: Card(
          //                                                 elevation: 3,
          //                                                 child: Container(
          //                                                   width: width,
          //                                                   height: height * 0.05,
          //                                                   alignment:
          //                                                       Alignment.center,
          //                                                   padding:
          //                                                       EdgeInsets.symmetric(
          //                                                           vertical: 10),
          //                                                   child: Row(
          //                                                     mainAxisAlignment:
          //                                                         MainAxisAlignment
          //                                                             .center,
          //                                                     crossAxisAlignment:
          //                                                         CrossAxisAlignment
          //                                                             .center,
          //                                                     children: [
          //                                                       Text(
          //                                                         "${value[i]["category"]["name"]}",
          //                                                         style: GoogleFonts.ptSans(
          //                                                             color: GlobalColors
          //                                                                 .themeColor2,
          //                                                             fontWeight:
          //                                                                 FontWeight
          //                                                                     .w500,
          //                                                             fontSize: width <
          //                                                                     500
          //                                                                 ? width / 35
          //                                                                 : width /
          //                                                                     35),
          //                                                       ),
          //                                                     ],
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   );
          //                                 },
          //                               );
          //                             });
          //                           },
          //                           child: Container(
          //                             alignment: Alignment.center,
          //                             child: Text(
          //                               workTask,
          //                               style: GoogleFonts.ptSans(
          //                                   color: GlobalColors.themeColor2,
          //                                   fontSize:
          //                                       width < 700 ? width / 30 : width / 45,
          //                                   fontWeight: FontWeight.w500,
          //                                   letterSpacing: 0),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       Expanded(child: Center(child: Text("")))
          //                     ],
          //                   ),
          //                 ),
          //                 if (is_removable_task == 1)
          //                     Container(
          //                       margin: EdgeInsets.only(bottom: 3),
          //                       decoration: BoxDecoration(
          //                           border: Border(
          //                               bottom: BorderSide(
          //                                   color: Color.fromARGB(255, 200, 196, 196),
          //                                   width: 0.5))),
          //                       constraints: BoxConstraints(
          //                           minWidth: width, minHeight: height * 0.05),
          //                       child: Row(
          //                         children: [
          //                           Expanded(
          //                               flex: 3,
          //                               child: Container(
          //                                 child: Text(
          //                                   "Removeable Count",
          //                                   style: GoogleFonts.ptSans(
          //                                       color: GlobalColors.black,
          //                                       fontSize: width < 700
          //                                           ? width / 30
          //                                           : width / 45,
          //                                       fontWeight: FontWeight.w400,
          //                                       letterSpacing: 0),
          //                                 ),
          //                               )),
          //                           Expanded(
          //                               child: Container(
          //                             child: Text(
          //                               "${product["removable_pending"]}",
          //                               style: GoogleFonts.ptSans(
          //                                   color: GlobalColors.black,
          //                                   fontSize:
          //                                       width < 700 ? width / 30 : width / 45,
          //                                   fontWeight: FontWeight.w400,
          //                                   letterSpacing: 0),
          //                             ),
          //                           )),
          //                           Expanded(
          //                               flex: 2,
          //                               child: Container(
          //                                 child: Text(
          //                                   "Used Count",
          //                                   style: GoogleFonts.ptSans(
          //                                       color: GlobalColors.black,
          //                                       fontSize: width < 700
          //                                           ? width / 30
          //                                           : width / 45,
          //                                       fontWeight: FontWeight.w400,
          //                                       letterSpacing: 0),
          //                                 ),
          //                               )),
          //                           Expanded(
          //                             child: Container(
          //                               alignment: Alignment.center,
          //                               child: TextField(
          //                                 controller: _controller,
          //                                   keyboardType: TextInputType.number,
          //                                   decoration: InputDecoration(
          //                                       contentPadding:
          //                                           const EdgeInsets.all(15),
          //                                       border: OutlineInputBorder(
          //                                           borderRadius:
          //                                               BorderRadius.circular(4))),
          //                                   onChanged: (value) {
          //                                     setState(() {
          //                                       removal_qty = int.parse(value);
          //                                     });
          //                                   }),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                 if (productList.isNotEmpty)
          //                   Text(
          //                     "Products",
          //                     style: GoogleFonts.ptSans(
          //                         color: GlobalColors.black,
          //                         fontSize: width < 500 ? width / 25 : width / 35),
          //                   ),
          //                 for (var i = 0; i < productList.length; i++)
          //                   Card(
          //                     elevation: 3,
          //                     child: Container(
          //                       child: Column(
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Expanded(
          //                                 flex: 1,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Checkbox(
          //                                     activeColor: GlobalColors.themeColor,
          //                                     checkColor: GlobalColors.white,
          //                                     value: selectedCheckbox
          //                                         .contains(productList[i]),
          //                                     onChanged: (bool? value) {
          //                                       if (value!) {
          //                                         setState(() {
          //                                           selectedCheckbox
          //                                               .add(productList[i]);
          //                                         });
          //                                       } else {
          //                                         setState(() {
          //                                           selectedCheckbox
          //                                               .remove(productList[i]);
          //                                         });
          //                                       }
          //                                     },
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 4,
          //                                 child: Container(
          //                                   child: Text(
          //                                     "${productList[i]["item_name"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 2,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Text(
          //                                     "${productList[i]["unit_name"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 1,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Text(
          //                                     "${productList[i]["pending_quantity"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           if (selectedCheckbox.contains(productList[i]))
          //                             if (productList[i]["serialnos"] != null)
          //                               Row(
          //                                 children: [
          //                                   Expanded(
          //                                     flex: 1,
          //                                     child: Center(
          //                                       child: Text(
          //                                         "S No:",
          //                                         style: GoogleFonts.ptSans(
          //                                             color: GlobalColors.themeColor2,
          //                                             fontSize: width < 500
          //                                                 ? width / 35
          //                                                 : width / 35),
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 6,
          //                                     child: Wrap(
          //                                       children: [
          //                                         for (var s = 0;
          //                                             s <
          //                                                 productList[i]["serialnos"]
          //                                                     .length;
          //                                             s++)
          //                                           InkWell(
          //                                             onTap: () {
          //                                               if (serialnosList.isEmpty) {
          //                                                 setState(() {
          //                                                   serialnosList.add({
          //                                                     "productId":
          //                                                         productList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": [
          //                                                       productList[i]
          //                                                           ["serialnos"][s]
          //                                                     ]
          //                                                   });
          //                                                 });
          //                                               }
          //                                               var data = serialnosList
          //                                                   .firstWhere(
          //                                                       (element) =>
          //                                                           element[
          //                                                               "productId"] ==
          //                                                           productList[i]
          //                                                               ["item_id"],
          //                                                       orElse: () {
          //                                                 return null;
          //                                               });
          //                                               if (data == null) {
          //                                                 setState(() {
          //                                                   serialnosList.add({
          //                                                     "productId":
          //                                                         productList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": [
          //                                                       productList[i]
          //                                                           ["serialnos"][s]
          //                                                     ]
          //                                                   });
          //                                                 });
          //                                               } else {
          //                                                 if (data["sNo"].contains(
          //                                                     productList[i]
          //                                                         ["serialnos"][s])) {
          //                                                   data["sNo"].remove(
          //                                                       productList[i]
          //                                                           ["serialnos"][s]);
          //                                                 } else {
          //                                                   data["sNo"].add(
          //                                                       productList[i]
          //                                                           ["serialnos"][s]);
          //                                                 }

          //                                                 if (data["sNo"].length <
          //                                                     1) {
          //                                                   serialnosList.remove({
          //                                                     "productId":
          //                                                         productList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": []
          //                                                   });
          //                                                 }
          //                                                 var getData = selectedCheckbox
          //                                                     .firstWhere(
          //                                                         (element) =>
          //                                                             element[
          //                                                                 "item_id"] ==
          //                                                             productList[i]
          //                                                                 ["item_id"],
          //                                                         orElse: () {
          //                                                   return null;
          //                                                 });
          //                                                 getData["used_serialNos"] =
          //                                                     data["sNo"];

          //                                                 getColors(
          //                                                     productList[i]
          //                                                         ["serialnos"][s],
          //                                                     productList[i]
          //                                                         ["item_id"]);

          //                                                 setState(() {
          //                                                   serialVisible =
          //                                                       !serialVisible;
          //                                                 });
          //                                                 setState(() {
          //                                                   serialVisible =
          //                                                       !serialVisible;
          //                                                 });
          //                                               }
          //                                             },
          //                                             child: Visibility(
          //                                               visible: serialVisible,
          //                                               child: Card(
          //                                                 color: getColors(
          //                                                     productList[i]
          //                                                         ["serialnos"][s],
          //                                                     productList[i]
          //                                                         ["item_id"]),
          //                                                 child: Padding(
          //                                                   padding:
          //                                                       const EdgeInsets.all(
          //                                                           10.0),
          //                                                   child: Text(
          //                                                     productList[i]
          //                                                             ["serialnos"][s]
          //                                                         .toString(),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           )
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                           if (selectedCheckbox.contains(productList[i]))
          //                             Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Row(
          //                                 children: [
          //                                   Expanded(
          //                                     flex: 4,
          //                                     child: Text(""),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 2,
          //                                     child: Text(
          //                                       "Used Quantity",
          //                                       style: GoogleFonts.ptSans(
          //                                           color: GlobalColors.themeColor2,
          //                                           fontSize: width < 500
          //                                               ? width / 35
          //                                               : width / 35),
          //                                     ),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 1,
          //                                     child: productList[i]["serialnos"] !=
          //                                             null
          //                                         ? Container(
          //                                             constraints: BoxConstraints(
          //                                                 minHeight: 50,
          //                                                 minWidth: 50),
          //                                             decoration: BoxDecoration(
          //                                                 borderRadius:
          //                                                     BorderRadius.circular(
          //                                                         4),
          //                                                 border: Border.all(
          //                                                     color: GlobalColors
          //                                                         .themeColor,
          //                                                     width: 2)),
          //                                             child: Center(
          //                                                 child: Text(getUsedserialNo(
          //                                                         productList[i]
          //                                                             ["item_id"])
          //                                                     .toString())),
          //                                           )
          //                                         : TextField(
          //                                             keyboardType:
          //                                                 TextInputType.number,
          //                                             decoration: InputDecoration(
          //                                                 contentPadding:
          //                                                     const EdgeInsets.all(
          //                                                         15),
          //                                                 border: OutlineInputBorder(
          //                                                     borderRadius:
          //                                                         BorderRadius
          //                                                             .circular(4))),
          //                                             onChanged: (value) {
          //                                               var data = selectedCheckbox
          //                                                   .firstWhere(
          //                                                       (element) =>
          //                                                           element[
          //                                                               "item_id"] ==
          //                                                           productList[i]
          //                                                               ["item_id"],
          //                                                       orElse: () {
          //                                                 return null;
          //                                               });
          //                                               data["used_quantity"] = value;

          //                                               // do something
          //                                             },
          //                                           ),
          //                                   )
          //                                 ],
          //                               ),
          //                             )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 if (OtherProductList.isNotEmpty)
          //                   Text(
          //                     "Other Products",
          //                     style: GoogleFonts.ptSans(
          //                         color: GlobalColors.black,
          //                         fontSize: width < 500 ? width / 25 : width / 35),
          //                   ),
          //                 for (var i = 0; i < OtherProductList.length; i++)
          //                   Card(
          //                     elevation: 3,
          //                     child: Container(
          //                       child: Column(
          //                         children: [
          //                           Row(
          //                             children: [
          //                               Expanded(
          //                                 flex: 1,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Checkbox(
          //                                     activeColor: GlobalColors.themeColor,
          //                                     checkColor: GlobalColors.white,
          //                                     value: selectedCheckbox
          //                                         .contains(OtherProductList[i]),
          //                                     onChanged: (bool? value) {
          //                                       if (value!) {
          //                                         setState(() {
          //                                           selectedCheckbox
          //                                               .add(OtherProductList[i]);
          //                                         });
          //                                       } else {
          //                                         setState(() {
          //                                           selectedCheckbox
          //                                               .remove(OtherProductList[i]);
          //                                         });
          //                                       }
          //                                     },
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 4,
          //                                 child: Container(
          //                                   child: Text(
          //                                     "${OtherProductList[i]["item_name"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 2,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Text(
          //                                     "${OtherProductList[i]["unit_name"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                               Expanded(
          //                                 flex: 1,
          //                                 child: Container(
          //                                   alignment: Alignment.center,
          //                                   child: Text(
          //                                     "${OtherProductList[i]["pending_quantity"]}",
          //                                     style: GoogleFonts.ptSans(
          //                                         color: GlobalColors.black,
          //                                         fontSize: width < 500
          //                                             ? width / 35
          //                                             : width / 35),
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           if (selectedCheckbox
          //                               .contains(OtherProductList[i]))
          //                             if (OtherProductList[i]["serialnos"] != null)
          //                               Row(
          //                                 children: [
          //                                   Expanded(
          //                                     flex: 1,
          //                                     child: Center(
          //                                       child: Text(
          //                                         "S No:",
          //                                         style: GoogleFonts.ptSans(
          //                                             color: GlobalColors.themeColor2,
          //                                             fontSize: width < 500
          //                                                 ? width / 35
          //                                                 : width / 35),
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 6,
          //                                     child: Wrap(
          //                                       children: [
          //                                         for (var s = 0;
          //                                             s <
          //                                                 OtherProductList[i]
          //                                                         ["serialnos"]
          //                                                     .length;
          //                                             s++)
          //                                           InkWell(
          //                                             onTap: () {
          //                                               if (serialnosList.isEmpty) {
          //                                                 setState(() {
          //                                                   serialnosList.add({
          //                                                     "productId":
          //                                                         OtherProductList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": [
          //                                                       OtherProductList[i]
          //                                                           ["serialnos"][s]
          //                                                     ]
          //                                                   });
          //                                                 });
          //                                               }
          //                                               var data = serialnosList
          //                                                   .firstWhere(
          //                                                       (element) =>
          //                                                           element[
          //                                                               "productId"] ==
          //                                                           OtherProductList[
          //                                                               i]["item_id"],
          //                                                       orElse: () {
          //                                                 return null;
          //                                               });
          //                                               if (data == null) {
          //                                                 setState(() {
          //                                                   serialnosList.add({
          //                                                     "productId":
          //                                                         OtherProductList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": [
          //                                                       OtherProductList[i]
          //                                                           ["serialnos"][s]
          //                                                     ]
          //                                                   });
          //                                                 });
          //                                               } else {
          //                                                 if (data["sNo"].contains(
          //                                                     OtherProductList[i]
          //                                                         ["serialnos"][s])) {
          //                                                   data["sNo"].remove(
          //                                                       OtherProductList[i]
          //                                                           ["serialnos"][s]);
          //                                                 } else {
          //                                                   data["sNo"].add(
          //                                                       OtherProductList[i]
          //                                                           ["serialnos"][s]);
          //                                                 }

          //                                                 if (data["sNo"].length <
          //                                                     1) {
          //                                                   serialnosList.remove({
          //                                                     "productId":
          //                                                         OtherProductList[i]
          //                                                             ["item_id"],
          //                                                     "sNo": []
          //                                                   });
          //                                                 }
          //                                                 var getData = selectedCheckbox
          //                                                     .firstWhere(
          //                                                         (element) =>
          //                                                             element[
          //                                                                 "item_id"] ==
          //                                                             OtherProductList[
          //                                                                     i]
          //                                                                 ["item_id"],
          //                                                         orElse: () {
          //                                                   return null;
          //                                                 });
          //                                                 getData["used_serialNos"] =
          //                                                     data["sNo"];

          //                                                 getColors(
          //                                                     OtherProductList[i]
          //                                                         ["serialnos"][s],
          //                                                     OtherProductList[i]
          //                                                         ["item_id"]);

          //                                                 setState(() {
          //                                                   serialVisible =
          //                                                       !serialVisible;
          //                                                 });
          //                                                 setState(() {
          //                                                   serialVisible =
          //                                                       !serialVisible;
          //                                                 });
          //                                               }
          //                                             },
          //                                             child: Visibility(
          //                                               visible: serialVisible,
          //                                               child: Card(
          //                                                 color: getColors(
          //                                                     OtherProductList[i]
          //                                                         ["serialnos"][s],
          //                                                     OtherProductList[i]
          //                                                         ["item_id"]),
          //                                                 child: Padding(
          //                                                   padding:
          //                                                       const EdgeInsets.all(
          //                                                           10.0),
          //                                                   child: Text(
          //                                                     OtherProductList[i]
          //                                                             ["serialnos"][s]
          //                                                         .toString(),
          //                                                   ),
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           )
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ],
          //                               ),
          //                           if (selectedCheckbox
          //                               .contains(OtherProductList[i]))
          //                             Padding(
          //                               padding: const EdgeInsets.all(8.0),
          //                               child: Row(
          //                                 children: [
          //                                   Expanded(
          //                                     flex: 4,
          //                                     child: Text(""),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 2,
          //                                     child: Text(
          //                                       "Used Quantity",
          //                                       style: GoogleFonts.ptSans(
          //                                           color: GlobalColors.themeColor2,
          //                                           fontSize: width < 500
          //                                               ? width / 35
          //                                               : width / 35),
          //                                     ),
          //                                   ),
          //                                   Expanded(
          //                                     flex: 1,
          //                                     child: OtherProductList[i]
          //                                                 ["serialnos"] !=
          //                                             null
          //                                         ? Container(
          //                                             constraints: BoxConstraints(
          //                                                 minHeight: 50,
          //                                                 minWidth: 50),
          //                                             decoration: BoxDecoration(
          //                                                 borderRadius:
          //                                                     BorderRadius.circular(
          //                                                         4),
          //                                                 border: Border.all(
          //                                                     color: GlobalColors
          //                                                         .themeColor,
          //                                                     width: 2)),
          //                                             child: Center(
          //                                                 child: Text(getUsedserialNo(
          //                                                         OtherProductList[i]
          //                                                             ["item_id"])
          //                                                     .toString())),
          //                                           )
          //                                         : TextField(
          //                                             keyboardType:
          //                                                 TextInputType.number,
          //                                             decoration: InputDecoration(
          //                                                 contentPadding:
          //                                                     const EdgeInsets.all(
          //                                                         15),
          //                                                 border: OutlineInputBorder(
          //                                                     borderRadius:
          //                                                         BorderRadius
          //                                                             .circular(4))),
          //                                             onChanged: (value) {
          //                                               var data = selectedCheckbox
          //                                                   .firstWhere(
          //                                                       (element) =>
          //                                                           element[
          //                                                               "item_id"] ==
          //                                                           OtherProductList[
          //                                                               i]["item_id"],
          //                                                       orElse: () {
          //                                                 return null;
          //                                               });
          //                                               data["used_quantity"] = value;

          //                                               // do something
          //                                             },
          //                                           ),
          //                                   )
          //                                 ],
          //                               ),
          //                             )
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 Container(
          //                   margin: EdgeInsets.only(bottom: 3),
          //                   constraints: BoxConstraints(
          //                       minWidth: width, minHeight: height * 0.05),
          //                   child: Row(
          //                     children: [
          //                       Expanded(
          //                           child: Container(
          //                         child: Text(
          //                           "Notes",
          //                           style: GoogleFonts.ptSans(
          //                               color: GlobalColors.black,
          //                               fontSize:
          //                                   width < 700 ? width / 30 : width / 45,
          //                               fontWeight: FontWeight.w400,
          //                               letterSpacing: 0),
          //                         ),
          //                       )),
          //                       Expanded(
          //                         flex: 2,
          //                         child: Container(
          //                           alignment: Alignment.center,
          //                           child: TextField(
          //                               decoration: InputDecoration(
          //                                   contentPadding: const EdgeInsets.all(15),
          //                                   border: OutlineInputBorder(
          //                                       borderRadius:
          //                                           BorderRadius.circular(4))),
          //                               onChanged: (value) {
          //                                 setState(() {
          //                                   notes = value.trim();
          //                                 });
          //                               }),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 Divider(),
          //                 ElevatedButton(
          //                   onPressed: () {
          //                     if (selectedEmployee.length < 1) {
          //                       QuickAlert.show(
          //                           context: context,
          //                           type: QuickAlertType.error,
          //                           title: "Add one or more participants",
          //                           autoCloseDuration: null);

          //                       return null;
          //                     }
          //                     if (workTask.isEmpty || workTask == "Select Task") {
          //                       QuickAlert.show(
          //                           context: context,
          //                           type: QuickAlertType.error,
          //                           title: "Select task",
          //                           autoCloseDuration: null);

          //                       return null;
          //                     }
          //                      if (selectedCheckbox.length<1&&is_removable_task != 1) {
          //                       QuickAlert.show(
          //                           context: context,
          //                           type: QuickAlertType.error,
          //                           title: "The product field is required",
          //                           autoCloseDuration: null);

          //                       return null;
          //                     }

          //                      for(var i=0;i<selectedCheckbox.length;i++){

          //                       if (selectedCheckbox[i]["enable_serial_no"] == 0) {
          //                         if (selectedCheckbox[i]
          //                                 .containsKey('used_quantity') ==
          //                             false) {
          //                           QuickAlert.show(
          //                               context: context,
          //                               type: QuickAlertType.error,
          //                               title:
          //                                   "Enter quantity of ${selectedCheckbox[i]["item_name"]}",
          //                               autoCloseDuration: null);

          //                           return null;
          //                         }else{
          //                           if (selectedCheckbox[i]["used_quantity"]==""){
          //                              QuickAlert.show(
          //                               context: context,
          //                               type: QuickAlertType.error,
          //                               title:
          //                                   "Enter quantity of ${selectedCheckbox[i]["item_name"]}",
          //                               autoCloseDuration: null);

          //                           return null;
          //                           }
          //                         }
          //                       }else{
          //                         if (selectedCheckbox[i]["used_serialNos"].length<1){
          //                             QuickAlert.show(
          //                               context: context,
          //                               type: QuickAlertType.error,
          //                               title:
          //                                   "Enter quantity of ${selectedCheckbox[i]["item_name"]}",
          //                               autoCloseDuration: null);

          //                           return null;
          //                         }
          //                       }

          //                     }
          // // if (is_removable_task.toString() == "1") {
          // //                         if (removal_qty == 0) {
          // //                           QuickAlert.show(
          // //                               context: context,
          // //                               type: QuickAlertType.error,
          // //                               title:
          // //                                   "Completed Quantity is not exceeds the pending Quantity",
          // //                               autoCloseDuration: null);

          // //                           return null;
          // //                         }
          // //                       }
          // Api()
          //     .ServiceWorkUpdateAdd(
          //         ref.watch(newToken),
          //         ref.watch(ServiceId),
          //         workTaskId,
          //         "${DateFormat("dd-MM-yyyy").format(workUpdateDate)}",
          //         selectedEmployee,
          //         notes,
          //         ref.watch(inChargeId),
          //         is_removable_task,
          //         removal_qty,
          //         selectedCheckbox)
          //                         .then((value) {

          //                           if(value.data["success"]){
          //                     widget.onclick();
          //                     Navigator.pop(context);

          //                           }else{

          //                              if (value.statusCode.toString() == "422" ||
          //                             value.statusCode.toString() == "500") {
          //                           QuickAlert.show(
          //                               context: context,
          //                               type: QuickAlertType.error,
          //                               title: "${value.data["error"]["message"]}",
          //                               autoCloseDuration: null);

          //                           return null;
          //                         }
          //                              QuickAlert.show(
          //                             context: context,
          //                             type: QuickAlertType.error,
          //                             title: "${value.data["message"]}",
          //                             autoCloseDuration: null);
          //                           }

          //                     });

          //                   },
          //                   child: Text("Add"),
          //                 )
          //               ],
          //             ),
          //           ),
        ],
      ),
    );
  }
}

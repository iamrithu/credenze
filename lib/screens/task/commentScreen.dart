import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../apis/api.dart';
import '../../const/global_colors.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final bool isCompleted;
  const CommentScreen({Key? key, required this.isCompleted}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  bool openComment = false;
  String cmd = "";
  List<dynamic> getComents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Api().getComand(ref.read(newToken)!, ref.read(publicTaskId)).then((value) {
      setState(() {
        getComents = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.7,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height * 0.7,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * 0.62,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
                          if (getComents.isEmpty)
                            Center(
                              child: Text(
                                "Comment not Found!",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor2,
                                    fontSize:
                                        width < 700 ? width / 30 : width / 45,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0),
                              ),
                            ),
                          if (getComents.isNotEmpty)
                            for (var i = 0; i < getComents.length; i++)
                              Card(
                                child: Container(
                                  width: width,
                                  height: height * 0.07,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: width * 0.1,
                                          height: height * 0.06,
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              getComents[i]["user"]
                                                  ["image_url"],
                                            ),
                                          )),
                                      Container(
                                        width: width * 0.6,
                                        constraints: BoxConstraints(
                                            minHeight: height * 0.07),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${getComents[i]["user"]["name"]}"
                                                  .trim(),
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.black,
                                                  fontSize: width < 700
                                                      ? width / 30
                                                      : width / 45,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0),
                                            ),
                                            Expanded(
                                              child: ListView(
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      Text(
                                                        "${getComents[i]["comment"]}",
                                                        style: GoogleFonts.ptSans(
                                                            color: GlobalColors
                                                                .themeColor2,
                                                            fontSize: width <
                                                                    700
                                                                ? width / 35
                                                                : width / 55,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Api()
                                      //         .removeComand(
                                      //             ref.watch(newToken)!,
                                      //             ref.watch(publicTaskId),
                                      //             getComents[i]["id"])
                                      //         .then((value) {
                                      //       Api()
                                      //           .getComand(ref.read(newToken)!,
                                      //               ref.read(publicTaskId))
                                      //           .then((value) {
                                      //         setState(() {
                                      //           getComents = value;
                                      //         });
                                      //       });
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //     width: width * 0.1,
                                      //     height: height * 0.06,
                                      //     child: Center(
                                      //       child: Icon(
                                      //         Icons.delete,
                                      //         size: width / 30,
                                      //         color: Colors.red,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              )
                        ],
                      ),
                    ),
                  ),
                  if (widget.isCompleted)
                    Container(
                      width: width,
                      height: height * 0.04,
                      child: Center(
                        child: ElevatedButton(
                          child: Text("Add Comment"),
                          onPressed: () {
                            setState(() {
                              openComment = true;
                            });
                          },
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          if (openComment)
            Container(
              width: width,
              height: height * 0.7,
              color: Color.fromARGB(40, 40, 39, 39),
              alignment: Alignment.center,
              child: Container(
                width: width * 0.9,
                height: height * 0.3,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add Comment",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 700 ? width / 30 : width / 45,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0),
                            ),
                          ],
                        ),
                        TextFormField(
                          maxLines: 4,
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.themeColor2,
                              fontSize: width < 700 ? width / 30 : width / 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0),
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          onChanged: (value) {
                            setState(() {
                              cmd = value;
                            });
                          },
                        ),
                        Container(
                          width: width,
                          height: height * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(
                                child: ElevatedButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    setState(() {
                                      openComment = false;
                                    });
                                  },
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  child: Text("Save"),
                                  onPressed: () {
                                    Api()
                                        .submitComand(ref.watch(newToken)!,
                                            ref.watch(publicTaskId), cmd)
                                        .then((value) {
                                      print(value.statusCode.toString());
                                      if (value.statusCode == 200) {
                                        Api()
                                            .getComand(ref.read(newToken)!,
                                                ref.read(publicTaskId))
                                            .then((value) {
                                          setState(() {
                                            getComents = value;
                                          });
                                          setState(() {
                                            openComment = false;
                                            cmd = "";
                                          });
                                        });
                                      } else {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.info,
                                          widget: Text(
                                            "${value.data["error"]["message"]}",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 30
                                                    : width / 48,
                                                fontWeight: FontWeight.w400,
                                                color: GlobalColors.themeColor2,
                                                letterSpacing: 0),
                                          ),
                                          autoCloseDuration:
                                              Duration(seconds: 1),
                                        );
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

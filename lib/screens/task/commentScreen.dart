import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../apis/api.dart';
import '../../const/global_colors.dart';

class CommentScreen extends ConsumerStatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

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
      height: height * 0.4,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height * 0.4,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * 0.32,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
                          if (getComents.isNotEmpty)
                            for (var i = 0; i < getComents.length; i++)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: GlobalColors.themeColor)),
                                    width: width * 0.1,
                                    height: height * 0.06,
                                    child: Center(
                                      child: Text(
                                        "${getComents[0]["id"]}",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: GlobalColors.themeColor)),
                                    width: width * 0.6,
                                    height: height * 0.06,
                                    child: Center(
                                      child: Text(
                                        "${getComents[0]["comment"]}",
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Api()
                                          .removeComand(
                                              ref.watch(newToken)!,
                                              ref.watch(publicTaskId),
                                              getComents[0]["id"])
                                          .then((value) {
                                        Api()
                                            .getComand(ref.read(newToken)!,
                                                ref.read(publicTaskId))
                                            .then((value) {
                                          setState(() {
                                            getComents = value;
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: GlobalColors.themeColor)),
                                      width: width * 0.1,
                                      height: height * 0.06,
                                      child: Center(child: Icon(Icons.delete)),
                                    ),
                                  )
                                ],
                              )
                        ],
                      ),
                    ),
                  ),
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
              height: height * 0.4,
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
                          maxLines: 2,
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
                                      Api()
                                          .getComand(ref.read(newToken)!,
                                              ref.read(publicTaskId))
                                          .then((value) {
                                        setState(() {
                                          getComents = value;
                                        });
                                      });
                                    });
                                    setState(() {
                                      openComment = false;
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

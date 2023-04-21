import 'package:credenze/const/global_colors.dart';
import 'package:credenze/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../river-pod/riverpod_provider.dart';

class CustomAppBar extends ConsumerWidget {
  final int page;
  const CustomAppBar({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = ref.watch(userDataProvider);
    return WillPopScope(
      onWillPop: (() async {
        return false;
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: page > 0
              ? IconButton(
                  onPressed: () {
                    if (page == 5) {
                      ref.read(initialIndex.notifier).update((state) => 1);
                    }
                    ref.read(pageIndex.notifier).update((state) => page == 5
                        // ? 3
                        // : page == 6
                        ? 1
                        : page == 5
                            ? 1
                            : page == 6
                                ? 5
                                : page == 7
                                    ? 2:page == 8?
                                    7
                                    : page == 10
                                        ? 3
                                        : 0);
                  },
                  color: GlobalColors.white,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: height * 0.025,
                  ),
                )
              : Card(
                  elevation: 10,
                  child: Container(
                    child: Image(
                      image: AssetImage("Assets/images/icon.png"),
                    ),
                  ),
                ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarColor: GlobalColors.themeColor,
              systemStatusBarContrastEnforced: true),
          automaticallyImplyLeading: false,
          title: Container(
            margin: EdgeInsets.all(10),
            child: page == 0
                ? Text(
                    "Dashboard",
                    style: GoogleFonts.ptSans(
                        fontSize: width < 700 ? width / 20 : width / 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0),
                  )
                : page == 1
                    ? Text(
                        "My Installations",
                        style: GoogleFonts.ptSans(
                            fontSize: width < 700 ? width / 20 : width / 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0),
                      )
                    : page == 2
                        ? Text(
                            "Service",
                            style: GoogleFonts.ptSans(
                                fontSize: width < 700 ? width / 20 : width / 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0),
                          )
                        // : page == 3
                        // ? Text(
                        // "Leads",
                        // style: GoogleFonts.ptSans(
                        // fontSize:
                        // width < 700 ? width / 20 : width / 24,
                        // fontWeight: FontWeight.w800,
                        // letterSpacing: 0),
                        // )
                        : page == 3
                            ? Text(
                                "Task",
                                style: GoogleFonts.ptSans(
                                    fontSize:
                                        width < 700 ? width / 20 : width / 24,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0),
                              )
                            // : page == 5
                            // ? Text(
                            // "Lead Details",
                            // style: GoogleFonts.ptSans(
                            // fontSize: width < 700
                            // ? width / 20
                            // : width / 24,
                            // fontWeight: FontWeight.w800,
                            // letterSpacing: 0),
                            // )
                            : page == 5 ||page==6
                                ? Text(
                                    "Installation Details",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 20
                                            : width / 24,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0),
                                  )
                                : page == 4 
                                ? Text(
                                    "Attendance Details",
                                    style: GoogleFonts.ptSans(
                                        fontSize: width < 700
                                            ? width / 20
                                            : width / 24,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0),
                                  )
                                : page ==8
                                        ? Text(
                                            "Service Details",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 20
                                                    : width / 24,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0),
                                          )
                                        : page == 9
                                        ? Text(
                                            "Profile",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 20
                                                    : width / 24,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0),
                                          )
                                        : page == 10
                                    ? Text(
                                        "Task Details",
                                        style: GoogleFonts.ptSans(
                                            fontSize: width < 700
                                                ? width / 20
                                                : width / 24,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0),
                                      ): page == 11
                                    ?  Text(
                                            "Overall Expenses",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 20
                                                    : width / 24,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0),
                                          ):
                                    Text(
                                            "Service Details",
                                            style: GoogleFonts.ptSans(
                                                fontSize: width < 700
                                                    ? width / 20
                                                    : width / 24,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0),
                                          ),
          ),
          actions: [
            if (page != 11)
              if (page != 9)
              user.when(
                  data: (_data) {
                    return InkWell(
                      onTap: () {
                        ref.read(pageIndex.notifier).update((state) => 9);
                      },
                      child: Container(
                        margin: EdgeInsets.all(3),
                        width: 50,
                        child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(2), // Border radius
                            child: ClipOval(
                              child: Image.network(
                                _data.imageUrl.toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  error: (e, s) => Center(
                        child: Text("${e}"),
                      ),
                  loading: () => Center(
                        child: CircularProgressIndicator.adaptive(),
                      ))
          ],
        ),
      ),
    );
  }
}

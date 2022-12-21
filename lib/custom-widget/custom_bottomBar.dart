import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../const/global_colors.dart';
import '../river-pod/riverpod_provider.dart';

class CustomBottomBar extends ConsumerWidget {
  CustomBottomBar({Key? key}) : super(key: key);
  List<IconData> navigationIcon = [
    FontAwesomeIcons.clock,
    Icons.install_desktop,
    FontAwesomeIcons.calendarDays,
    FontAwesomeIcons.chartBar,
    Icons.settings_applications,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final int _page = ref.watch(pageIndex);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Card(
          margin: EdgeInsets.only(
            bottom: height * 0.02,
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: GlobalColors.themeColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            width: width,
            height: height * 0.065,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < navigationIcon.length; i++)
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _page == i
                                      ? GlobalColors.themeColor
                                      : GlobalColors.white,
                                  width: 2))),
                      child: IconButton(
                        onPressed: () {
                          ref.read(pageIndex.notifier).update((state) => i);
                        },
                        color: _page == i
                            ? GlobalColors.themeColor
                            : GlobalColors.themeColor2,
                        icon: Icon(
                          navigationIcon[i],
                          size: _page == i ? height * 0.025 : height * 0.02,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

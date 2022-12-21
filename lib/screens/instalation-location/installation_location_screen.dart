import 'package:credenze/const/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InstallationLocationScreen extends StatefulWidget {
  const InstallationLocationScreen({Key? key}) : super(key: key);

  @override
  _InstallationLocationScreenState createState() =>
      _InstallationLocationScreenState();
}

class _InstallationLocationScreenState
    extends State<InstallationLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: width,
      height: height * 0.4,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 15,
        ),
      ),
    )
        // body: CustomScrollView(slivers: [
        //   SliverAppBar(
        //     pinned: true,
        //     expandedHeight: height * 0.6,
        //     flexibleSpace: FlexibleSpaceBar(
        //       background: Container(
        //           width: width,
        //           height: height * 4,
        //           color: Colors.pink,
        //           child: GoogleMap(
        //             initialCameraPosition: CameraPosition(
        //               target: LatLng(37.43296265331129, -122.08832357078792),
        //               zoom: 14,
        //             ),
        //           )),
        //     ),
        //     bottom: PreferredSize(
        //       preferredSize: Size(width, height * 0.06),
        //       child: Container(
        //         width: width,
        //         height: height * 0.06,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20)),
        //           color: GlobalColors.white,
        //         ),
        //         child: Center(child: Text("rithi")),
        //       ),
        //     ),
        //   ),
        //   SliverToBoxAdapter(
        //     child: Column(
        //       children: [
        //         Container(
        //           width: width,
        //           height: height * 1,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //             ),
        //           ),
        //         ),
        //         Text("sldvhwoishgvwoefhbwkufvwkuehvwkeuhfbwkejfbwkefbeiubhefbek"),
        //       ],
        //     ),
        //   )
        // ]),
        );
  }
}

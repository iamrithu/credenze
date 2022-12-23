import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsAndLocation {
  openMapsSheet(context, lat, long) async {
    Coords location = Coords(lat, long);
    try {
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showDirections(
                            destination: location,
                            destinationTitle: "Destination",
                          );
                          Navigator.pop(context);
                        },
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Position> locationPermisson() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location Service Are Disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Service Are Disabled");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permissions are Permanently Disabled");
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getCamera() async {
    final ImagePicker _picker = ImagePicker();

    try {
      final image = await _picker.pickImage(
          source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

      if (image == null) return;
      final imageTemporay = File(image.path);
      return imageTemporay;
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }
}

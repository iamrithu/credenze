import 'dart:io';

import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apis/api.dart';
import '../../../const/global_colors.dart';

class FileScreen extends ConsumerStatefulWidget {
  final double? height;
  final double? width;

  const FileScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  ConsumerState<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends ConsumerState<FileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext) {
    final FilesDetails = ref.watch(fileProvider);
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          String? token = await prefs.getString('token');
          final id = ref.watch(overViewId);

          print(id.toString());
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result != null) {
            File file = File(result.files.single.path!);

            Api().AddFile(token: token!, id: id, file: file).then((value) {
              print("demo000 $value");
            });
          }
        },
        icon: Icon(
          Icons.file_copy,
          color: GlobalColors.white,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.themeColor,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        label: Text(
          "Add File",
          style: GoogleFonts.ptSans(
              color: GlobalColors.white,
              fontSize:
                  widget.width! < 700 ? widget.width! / 28 : widget.width! / 45,
              fontWeight: FontWeight.w400,
              letterSpacing: 0),
        ),
      ),
      body: FilesDetails.when(
          data: (_data) {
            return RefreshIndicator(
                color: Colors.white,
                backgroundColor: GlobalColors.themeColor,
                strokeWidth: 4.0,
                onRefresh: () async {
                  return Future<void>.delayed(const Duration(seconds: 2), () {
                    return ref.refresh(fileProvider);
                  });
                },
                child: GridView.count(
                  crossAxisCount: widget.width! < 500 ? 3 : 4,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  children: [
                    for (var i = 0; i < _data.length; i++)
                      InkWell(
                        onTap: () async {
                          openFile(_data[i].fileUrl!, _data[i].filename!);
                        },
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _data[i].icon == "images"
                                  ? Image.network(
                                      "${_data[i].fileUrl!}",
                                      width: widget.width! * 0.12,
                                    )
                                  : _data[i].icon == "fa-file-pdf"
                                      ? Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: widget.width! * 0.12,
                                          color:
                                              Color.fromARGB(255, 199, 56, 45),
                                        )
                                      : _data[i].icon == "fa-file-excel"
                                          ? Icon(
                                              FontAwesomeIcons.fileExcel,
                                              size: widget.width! * 0.12,
                                              color: Color.fromARGB(
                                                  255, 8, 102, 36),
                                            )
                                          : _data[i].icon == "fa-file-word"
                                              ? Icon(
                                                  FontAwesomeIcons.fileWord,
                                                  size: widget.width! * 0.12,
                                                  color: Color.fromARGB(
                                                      255, 83, 141, 223),
                                                )
                                              : Icon(
                                                  Icons.file_copy,
                                                  size: widget.width! * 0.12,
                                                  color: Colors.blue,
                                                ),
                              Text(
                                "${_data[i].filename!}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.themeColor2,
                                    fontSize: widget.width! < 700
                                        ? widget.width! / 34
                                        : widget.width! / 45,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ));
          },
          error: (err, s) =>
              Text("Not authenticated to perform this request   $err"),
          loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              )),
    );
  }

  Future openFile(String? url, String? fileName) async {
    final file = await downloadfile(url!, fileName!);

    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadfile(String url, String name) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File('${appDocDir.path}/$name');
    try {
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}

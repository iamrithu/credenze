import 'dart:convert';
import 'dart:io';
import 'package:credenze/const/secret.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/installation-overview-model.dart';
import 'package:credenze/models/members_model.dart';
import 'package:credenze/models/task-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/file-model.dart';

class Api {
  final dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: Secret.api,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));

  Future authendication(String email, String password) async {
    try {
      var params = {"email": email, "password": password};
      Response response = await dio.post(
        "login",
        data: jsonEncode(params),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future DayIn(token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.post(
        "attendance/clockin",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future DayOut(token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.post(
        "attendance/clockout",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future todayLogin(token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.post(
        "attendance/today",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<String> ClockIn({
    required String? token,
    required int? id,
    required String? latitude,
    required String? longitude,
    required File photo,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final bytes = photo.readAsBytesSync();
    String base64Image = "data:image/png;base64," + base64Encode(bytes);
    var params = {
      "latitude": latitude!,
      "longitude": longitude!,
      "photo": base64Image,
    };

    try {
      Response response = await dio.post(
        "installation/$id/dayin",
        data: jsonEncode(params),
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> ClockOut({
    required String? token,
    required int? id,
    required String? latitude,
    required String? longitude,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    var params = {"latitude": latitude, "longitude": longitude};

    try {
      Response response = await dio.post(
        "installation/$id/dayout",
        data: jsonEncode(params),
      );

      print("red" + response.toString());

      return response.toString();
    } on DioError catch (e) {
      print("err" + e.toString());
      return e.response.toString();
    }
  }

  Future InstallationAttendence(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "installation/$id/attendance",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<String> AddFile({
    required String? token,
    required int? id,
    required File file,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      String fileName = file.path.split('/').last;
      print(fileName);

      FormData data = FormData.fromMap({
        "file[]": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        "installation/$id/files/add",
        data: data,
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> DeleteFile({
    required String? token,
    required int? id,
    required int? fileId,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    print(token.toString());
    print(id.toString);
    print(fileId.toString);

    try {
      Response response = await dio.post(
        "installation/$id/files/$fileId/destroy",
      );

      print("dem" + response.toString());

      return response.toString();
    } on DioError catch (e) {
      print("dem" + e.response.toString());

      return e.response.toString();
    }
  }
}

class ProviderApi {
  final dio = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: Secret.api,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));
  Future<UserModel> UserData(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "user/profile",
    );
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(response.data["data"]);
      return user;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<InstallationModel>> InstalationModel(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/list",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<InstallationModel> installations = [];
      data.map((e) {
        installations.add(InstallationModel.fromJson(e));
      }).toList();
      return installations;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<InstallationOverViewModel> InstallationOverView(
      String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/overview",
    );
    if (response.statusCode == 200) {
      InstallationOverViewModel overView =
          InstallationOverViewModel.fromJson(response.data["data"]);
      return overView;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<MemberModel>> Members(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/members",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];

      List<MemberModel> members = [];
      data.map((e) {
        members.add(MemberModel.fromJson(e));
      }).toList();
      return members;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<TaskModel>> Tasks(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/task",
    );

    print(response.toString());
    if (response.statusCode == 200) {
      List data = response.data["data"];

      print(response.toString());
      List<TaskModel> tasks = [];
      data.map((e) {
        tasks.add(TaskModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<FileModel>> Files(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/files",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<FileModel> installations = [];
      data.map((e) {
        installations.add(FileModel.fromJson(e));
      }).toList();
      return installations;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}

final provider = Provider<ProviderApi>((red) => ProviderApi());

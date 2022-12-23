import 'dart:convert';
import 'dart:io';
import 'package:credenze/const/secret.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/installation-overview-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future ClockIn(String? token, int? id, String? latitude, String? longitude,
      File photo) async {
    String fileName = photo.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(photo.path, filename: fileName),
    });
    var params = {
      "latitude": latitude!,
      "longitude": longitude!,
      "photo": formData.files,
    };

    try {
      Response response = await dio.post("installation/$id/dayin",
          data: jsonEncode(params),
          options: Options(contentType: 'multipart/form-data'));
      print(response.toString());

      return response;
    } on DioError catch (e) {
      print(e.toString());

      return e.response;
    }
  }

  Future ClockOut(
    String token,
    int id,
    String latitude,
    String longitude,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    var params = {latitude, longitude};

    try {
      Response response = await dio.post(
        "installation/$id/dayout",
        data: jsonEncode(params),
      );

      return response;
    } on DioError catch (e) {
      return e.response;
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
}

final provider = Provider<ProviderApi>((red) => ProviderApi());

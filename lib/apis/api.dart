// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:credenze/const/secret.dart';
import 'package:credenze/models/expenses-model.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/installation-overview-model.dart';
import 'package:credenze/models/members_model.dart';
import 'package:credenze/models/task-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:credenze/river-pod/riverpod_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense-category-model.dart';
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

      return response.toString();
    } on DioError catch (e) {
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

  Future<String> AddExpense(
      {required String? token,
      required int? id,
      required int? category_id,
      required File file,
      required String? date,
      required String? amount,
      required String? note,
      required int? fromPlace,
      required int? distance}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName = file.path.split('/').last;
      FormData data = FormData.fromMap({
        "date": date,
        "category_id": category_id,
        "amount": amount,
        "notes": note,
        "attachment": file == null
            ? await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              )
            : File(""),
        "from_place": fromPlace,
        "distance": distance
      });
      Response response = await dio.post(
        "installation/$id/expense/add",
        data: data,
      );
      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> updateExpense(
      {required String? token,
      required int? id,
      required int? expenseId,
      required int? category_id,
      required File file,
      required String? date,
      required String? amount,
      required String? note,
      required int? fromPlace,
      required int? distance}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName = file.path.split('/').last;
      FormData data = FormData.fromMap({
        "date": date,
        "category_id": category_id,
        "amount": amount,
        "notes": note,
        "attachment": file == null
            ? await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              )
            : File(""),
        "from_place": fromPlace,
        "distance": distance
      });
      Response response = await dio.post(
        "installation/$id/expense/$expenseId/update",
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

    try {
      Response response = await dio.post(
        "installation/$id/files/$fileId/destroy",
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future workUpdate(String? token, int? id, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await dio.get(
        "installation/datewiseparticipants/$id/$date",
      );
      return response.data;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future addWorkUpdate(
      String? token,
      int? installation_id,
      int? category_id,
      String? date,
      int? participants,
      String? description,
      int? site_incharge,
      List itemList) async {
    var formData = FormData.fromMap({
      'installation_id': installation_id,
      'category_id': category_id,
      'work_date': date,
      'site_incharge': site_incharge,
      'participants[0]': participants,
      'description': description
    });
    itemList.map((e) {
      print(e["product_id"].toString());
      formData.fields.add(MapEntry(
          "items[${e["product_id"]}][product_id]", e["product_id"].toString()));
      formData.fields.add(MapEntry(
          "items[${e["product_id"]}][unit_id]", e["unit_id"].toString()));
      formData.fields.add(MapEntry(
          "items[${e["product_id"]}][quantity]", e["quantity"].toString()));
      formData.fields.add(MapEntry(
          "items[${e["product_id"]}][enable_serial_no]",
          e["enable_serial_no"].toString()));
    }).toList();
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await dio.post(
          "installation/$installation_id/workupdate/create",
          data: formData);
      return response.data;
    } on DioError catch (e) {
      return e.response;
    }

    // print("$token");
    // print("$installation_id");

    // print("$category_id");

    // print("$date");

    // print("$participants");
    // print("$description");

    // print("$site_incharge");

    // print("$itemList");
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

  Future<List<InstallationModel>> InstalationModelList(
      String? token, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print(date);
    var params = {
      "date": date,
    };
    Response response = await dio.post(
      "installation/listbydate",
      data: jsonEncode(params),
    );

    print(response.toString());
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

  Future<List<MemberModel>> Members(
      String? token, int? id, int? checkId) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/members",
    );
    if (response.statusCode == 200) {
      List data = response.data["data"];

      var newdata =
          data.firstWhere(((element) => element["site_incharge"] != null));

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

    if (response.statusCode == 200) {
      List data = response.data["data"];

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

  Future<List<ExpensesModel>> Expenses(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/expense",
    );
    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ExpensesModel> tasks = [];
      data.map((e) {
        tasks.add(ExpensesModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<ExpenseCategoryModel>> ExpensesCategory(
      String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/expense/category",
    );
    if (response.statusCode == 200) {
      List data = response.data["data"];

      List<ExpenseCategoryModel> tasks = [];
      data.map((e) {
        tasks.add(ExpenseCategoryModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}

final provider = Provider<ProviderApi>((red) => ProviderApi());

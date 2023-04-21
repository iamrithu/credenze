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
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense-category-model.dart';
import '../models/file-model.dart';
import '../models/instalation-task-details-model.dart';
import '../models/instalation-task-model.dart';
import '../models/installation-employee-model.dart';
import '../models/installation-work-taskList-model.dart';
import '../models/installation-work-updatedList-model.dart';
import '../models/leaveListModel.dart';
import '../models/permoissionListModel.dart';
import '../models/service-detail-model.dart';
import '../models/service-expense-model.dart';
import '../models/service-file-model.dart';
import '../models/service-list-model.dart';
import '../models/service-member-model.dart';
import '../models/service-task-detail-model.dart';
import '../models/service-task-model.dart';
import '../models/service-workupdate-model.dart';
import '../models/work-update-model.dart';

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
        "http://dev.credenze.in/api/login",
        data: jsonEncode(params),
      );
      print(response.toString());
      return response;
    } on DioError catch (e) {
      print(e.response.toString());
      return e.response;
    }
  }

  Future DayIn(String token, String lat, String long) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    var params = {"longitude": long, "latitude": lat};

    try {
      Response response =
          await dio.post("attendance/clockin", data: jsonEncode(params));

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future DayOut(String token, String lat, String long) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    var params = {"longitude": long, "latitude": lat};

    try {
      Response response =
          await dio.post("attendance/clockout", data: jsonEncode(params));

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

  Future<String> CheckCanSubmit({
    required String? token,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "attendance/expensedetailes",
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future DayOutExpense({
    required String? token,
    required int? reference_id,
    required String? dep_type,
    required int? category_id,
    required String? from_place,
    required String? to_place,
    required String? distance,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      var params = {
        "category_id": category_id.toString(),
        "dep_type": dep_type,
        "distance": distance,
        "from_place": from_place,
        "reference_id": reference_id.toString(),
        "to_place": to_place,
      };
      Response response =
          await dio.post("attendance/dayoutexpense", data: jsonEncode(params));
      return response;
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

      print(response.toString());
      return response.toString();
    } on DioError catch (e) {
      print(e.response.toString());
      return e.response.toString();
    }
  }

  Future getServiceIncaherge(String token, int id, String date) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    print("wwservice/${id}/siteincharge/${date}");
    try {
      Response response = await dio.get(
        "service/${id}/siteincharge/${date}",
      );
      print("--" + response.toString());
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<String> ServiceClockIn({
    required String? token,
    required int? id,
    required String? latitude,
    required String? longitude,
    required File? photo,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    String fileName = photo == null ? "" : photo.path.split('/').last;

    FormData newData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(
        photo!.path,
        filename: fileName,
      ),
      "latitude": latitude!,
      "longitude": longitude!,
    });

    print("xx${newData.files}");
    try {
      Response response = await dio.post(
        "service/${id}/dayin",
        data: newData,
      );
      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> ServiceClockOut({
    required String? token,
    required int? id,
    required String? latitude,
    required String? longitude,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    var params = {"latitude": latitude, "longitude": longitude};
    print("ww" + id.toString());
    print("ww" + latitude.toString());
    print("ww" + longitude.toString());

    try {
      Response response = await dio.post(
        "service/${id}/dayout",
        data: jsonEncode(params),
      );
      print("ww" + response.toString());
      return response.toString();
    } on DioError catch (e) {
      print("ww" + e.response.toString());

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

  Future ServiceAttendence(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "service/${id}/attendance",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future expansesCategory(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "installation/${id}/expenses/categories",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future serviceExpansesCategory(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "service/${id}/expenses/categories",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future expansesLocation(String? token, int? id, String date) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "installation/${id}/expenses/getlocation/${date}",
      );

      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future serviceExpansesLocation(String? token, int? id, String date) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "service/${id}/expenses/getlocation/${date}",
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

      print("l" + data.fields.toString());

      Response response = await dio.post(
        "installation/$id/files/add",
        data: data,
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> ServiceAddFile({
    required String? token,
    required int? id,
    required List<File> file,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      FormData data = FormData();

      for (var i = 0; i < file.length; i++) {
        String fileName = file[i].path.split('/').last;

        data.files.add(MapEntry(
            "file[]",
            await MultipartFile.fromFile(
              file[i].path,
              filename: fileName,
            )));
      }

      Response response = await dio.post(
        "service/${id}/files/upload",
        data: data,
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future AddExpense(
      {required String? token,
      required int? id,
      required File? file,
      required Map<String, dynamic> data}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName = file == null ? "" : file.path.split('/').last;

      FormData datas = FormData.fromMap({
        "attachment": file == null
            ? ""
            : await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              ),
        "installation_id": data["installation_id"],
        "user_id": data["user_id"],
        "expenses_date": data["expenses_date"],
        "category_id": data["category_id"],
        "from_place": data["from_place"],
        "to_place": data["to_place"],
        "distance": data["distance"],
        "amount": data["amount"],
      });

      Response response = await dio.post(
        "installation/${id}/expenses/save",
        data: datas,
      );
      return response;
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future AddServiceExpense(
      {required String? token,
      required int? id,
      required File? file,
      required Map<String, dynamic> data}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName = file == null ? "" : file.path.split('/').last;

      FormData datas = FormData.fromMap({
        "attachment": file == null
            ? ""
            : await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              ),
        "installation_id": data["installation_id"],
        "user_id": data["user_id"],
        "expenses_date": data["expenses_date"],
        "category_id": data["category_id"],
        "from_place": data["from_place"],
        "to_place": data["to_place"],
        "distance": data["distance"],
        "amount": data["amount"],
      });

      Response response = await dio.post(
        "service/${id}/expenses/save",
        data: datas,
      );
      return response;
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future updateExpense(
      {required String? token,
      required int? id,
      required File? file,
      required Map<String, dynamic> data,
      required int expenseId}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName =
          file == null || file == " " ? "" : file.path.split('/').last;

      FormData newData = FormData.fromMap({
        "attachment": file == null
            ? ""
            : await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              ),
        "installation_id": data["installation_id"],
        "user_id": data["user_id"],
        "expenses_date": data["expenses_date"],
        "category_id": data["category_id"],
        "from_place": data["from_place"],
        "to_place": data["to_place"],
        "distance": data["distance"],
        "amount": data["amount"],
        "status": data["status"],
      });


      Response response = await dio.post(
        "installation/${id}/expenses/update/${expenseId}",
        data: newData,
      );
      return response;
    } on DioError catch (e) {

      return e.response;
    }
  }

  Future serviceUpdateExpense(
      {required String? token,
      required int? id,
      required File? file,
      required Map<String, dynamic> data,
      required int expenseId}) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      String fileName =
          file == null || file == " " ? "" : file.path.split('/').last;

      FormData newData = FormData.fromMap({
        "attachment": file == null
            ? ""
            : await MultipartFile.fromFile(
                file.path,
                filename: fileName,
              ),
        "installation_id": data["installation_id"],
        "user_id": data["user_id"],
        "expenses_date": data["expenses_date"],
        "category_id": data["category_id"],
        "from_place": data["from_place"],
        "to_place": data["to_place"],
        "distance": data["distance"],
        "amount": data["amount"],
        "status": data["status"],
      });

      print("z" + newData.toString());

      Response response = await dio.post(
        "service/${id}/expenses/update/${expenseId}",
        data: newData,
      );
      return response;
    } on DioError catch (e) {

      return e.response;
    }
  }

  // Future<String> updateExpense(
  //     {required String? token,
  //     required int? id,
  //     required int? expenseId,
  //     required int? category_id,
  //     required File file,
  //     required String? date,
  //     required String? amount,
  //     required String? note,
  //     required int? fromPlace,
  //     required int? distance}) async {
  //   dio.options.headers["Authorization"] = "Bearer $token";
  //   try {
  //     String fileName = file.path.split('/').last;
  //     FormData data = FormData.fromMap({
  //       "date": date,
  //       "category_id": category_id,
  //       "amount": amount,
  //       "notes": note,
  //       "attachment": file == null
  //           ? await MultipartFile.fromFile(
  //               file.path,
  //               filename: fileName,
  //             )
  //           : File(""),
  //       "from_place": "",
  //       "distance": 0
  //     });
  //     Response response = await dio.post(
  //       "installation/$id/expense/$expenseId/update",
  //       data: data,
  //     );

  //     return response.toString();
  //   } on DioError catch (e) {
  //     return e.response.toString();
  //   }
  // }

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

  Future<String> DeleteServiceFile({
    required String? token,
    required int? id,
    required int? fileId,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "service/${id}/files/${fileId}/remove",
      );

      return response.toString();
    } on DioError catch (e) {
      return e.response.toString();
    }
  }

  Future<String> ExpensePlace({
    required String? token,
    required int? id,
  }) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(
        "installation/$id/expense/checkplace",
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
      List<int> participants,
      String? description,
      int? site_incharge,
      List itemList,
      List serialList) async {
    final formData = FormData.fromMap({
      'installation_id': installation_id,
      'category_id': category_id,
      'work_date': date,
      'site_incharge': site_incharge,
      'participants[0]':
          "${participants.toString().replaceAll("[", "").replaceAll("]", "")}",
      'description': description!.isEmpty ? "--" : description
    });

    print("serialValue" + itemList.toString());
    serialList.map((e) {
      print(e["product_id"].toString());
      formData.fields.add(MapEntry(
          "serial_no[${e["productId"]}][${e["serial_no"]}]",
          e["value"].toString()));
    }).toList();

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

    print("fielsds" + formData.fields.toString());

    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await dio.post(
          "installation/$installation_id/workupdate/create",
          data: formData);
      print("demoxx" + response.toString());

      return response.toString();
    } on DioError catch (e) {
      print("demoxx" + e.response.toString());
      return e.response;
    }
  }

  Future WorkUpdateAdd(
    String? token,
    int? installation_id,
    int? task_id,
    String? task_date,
    List participants,
    String? description,
    int? site_incharge,
    int? is_removable_task,
    int? removed_quantity,
    List productList,
  ) async {
    final formData = FormData.fromMap({});
    print(formData.fields.toString());

    formData.fields.add(MapEntry("task_id", task_id.toString()));
    formData.fields
        .add(MapEntry("installation_id", installation_id.toString()));
    formData.fields.add(MapEntry("workupdate_date", task_date.toString()));
    formData.fields
        .add(MapEntry("removed_quantity", removed_quantity.toString()));
    formData.fields
        .add(MapEntry("is_removable_task", is_removable_task.toString()));
    formData.fields.add(MapEntry("description", description.toString()));

    for (var i = 0; i < participants.length; i++) {
      formData.fields.add(
          MapEntry("participants_id[${i}]", participants[i].userid.toString()));
    }

    if (productList.isNotEmpty) {
      for (var i = 0; i < productList.length; i++) {
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][item_id]",
            productList[i]["item_id"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][item_name]",
            productList[i]["item_name"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][unit_id]",
            productList[i]["unit_id"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][enable_serial_no]",
            productList[i]["enable_serial_no"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][task_product]",
            productList[i]["task_product"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][task_item_id]",
            productList[i]["task_item_id"].toString() == "null"
                ? ""
                : productList[i]["task_item_id"].toString()));

        if (productList[i]["enable_serial_no"].toString() == "1") {
          formData.fields.add(MapEntry(
              "item[${productList[i]["item_id"]}][quantity]",
              productList[i]["used_serialNos"].length.toString()));
        } else {
          formData.fields.add(MapEntry(
              "item[${productList[i]["item_id"]}][quantity]",
              productList[i]["used_quantity"]));
        }

        if (productList[i]["used_serialNos"] != null) {
          for (var j = 0; j < productList[i]["used_serialNos"].length; j++) {
            formData.fields.add(MapEntry(
                "serial_no[${productList[i]["item_id"]}][${j + 1}]",
                productList[i]["used_serialNos"][j]));
          }
        }
      }
    }
    print(formData.fields.toString());

    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await dio.post(
          "installation/${installation_id}/workupdates/save",
          data: formData);

      return response;
    } on DioError catch (e) {
      print("demoxx" + e.response.toString());
      return e.response;
    }
  }

  Future addPublicExpense(String token, String dep_type, int reference_id,
      List<Map<String, dynamic>> data) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    final formData = FormData.fromMap({
      "dep_type": dep_type,
      "reference_id": reference_id,
    });

    for (var i = 0; i < data.length; i++)
      if (data[i]["category_id"] == 1) {
        formData.fields.add(MapEntry(
            "item[${i}][category_id]", data[i]["category_id"].toString()));
        formData.fields.add(MapEntry(
            "item[${i}][from_place]", data[i]["from_place"].toString()));
        formData.fields.add(
            MapEntry("item[${i}][to_place]", data[i]["to_place"].toString()));
        formData.fields.add(
            MapEntry("item[${i}][distance]", data[i]["distance"].toString()));
        formData.fields.add(MapEntry("item[${i}][amount]", "0"));
        formData.fields.add(MapEntry("item[${i}][notes]", "--"));
      } else {
        formData.fields.add(MapEntry(
            "item[${i}][category_id]", data[i]["category_id"].toString()));
        formData.fields
            .add(MapEntry("item[${i}][amount]", data[i]["amount"].toString()));
        formData.fields.add(MapEntry("item[${i}][notes]", "--"));
      }

    print(formData.fields.toString());
    try {
      var response = await dio.post("attendance/dayoutexpense", data: formData);

      print(response.toString());
      return response.toString();
    } on DioError catch (e) {
      print("demoxx" + e.response.toString());
      return e.response;
    }
  }

  Future ServiceWorkUpdateAdd(
    String? token,
    int? service_id,
    int? task_id,
    String? task_date,
    List participants,
    String? description,
    int? site_incharge,
    int? is_removable_task,
    int? removed_quantity,
    List productList,
  ) async {
    print(productList.toString());
    final formData = FormData.fromMap({});

    formData.fields.add(MapEntry("task_id", task_id.toString()));
    formData.fields.add(MapEntry("service_id", service_id.toString()));
    formData.fields.add(MapEntry("workupdate_date", task_date.toString()));
    formData.fields
        .add(MapEntry("removed_quantity", removed_quantity.toString()));
    formData.fields
        .add(MapEntry("is_removable_task", is_removable_task.toString()));
    formData.fields.add(MapEntry("description", description.toString()));

    for (var i = 0; i < participants.length; i++) {
      formData.fields.add(
          MapEntry("participants_id[${i}]", participants[i].userid.toString()));
    }

    if (productList.isNotEmpty) {
      for (var i = 0; i < productList.length; i++) {
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][item_id]",
            productList[i]["item_id"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][item_name]",
            productList[i]["item_name"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][unit_id]",
            productList[i]["unit_id"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][enable_serial_no]",
            productList[i]["enable_serial_no"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][task_product]",
            productList[i]["task_product"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][sp_product]",
            productList[i]["sp_product"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][serial_no]",
           
                 productList[i]["serial_no"].toString()));
        formData.fields.add(MapEntry(
            "item[${productList[i]["item_id"]}][task_item_id]",
            productList[i]["task_item_id"].toString() == "null"
                ? ""
                : productList[i]["task_item_id"].toString()));

        if (productList[i]["enable_serial_no"].toString() == "1") {
          formData.fields.add(MapEntry(
              "item[${productList[i]["item_id"]}][quantity]",
              productList[i]["used_serialNos"].length.toString()));
        } else {
          formData.fields.add(MapEntry(
              "item[${productList[i]["item_id"]}][quantity]",
              productList[i]["used_quantity"]));
        }

        if (productList[i]["used_serialNos"] != null) {
          for (var j = 0; j < productList[i]["used_serialNos"].length; j++) {
            formData.fields.add(MapEntry(
                "serial_no[${productList[i]["item_id"]}][${j + 1}]",
                productList[i]["used_serialNos"][j]));
          }
        }
      }
    }
    print(formData.fields.toString());
    dio.options.headers["Authorization"] = "Bearer $token";
    try {
      var response = await dio.post("service/${service_id}/workupdates/save",
          data: formData);
      print(response.toString());

      return response;
    } on DioError catch (e) {
      print(e.response.toString());
      return e.response;
    }
  }

  Future<List<InstallationEmployeeModel>> workParticipants(
      String? token, int? id, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "installation/${id}/workupdates/participants/${date}",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];

      List<InstallationEmployeeModel> tasks = [];
      data.map((e) {
        tasks.add(InstallationEmployeeModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<InstallationEmployeeModel>> serviceWorkParticipants(
      String? token, int? id, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "service/${id}/workupdates/participants/${date}",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];

      List<InstallationEmployeeModel> tasks = [];
      data.map((e) {
        tasks.add(InstallationEmployeeModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future workTaskList(
    String? token,
    int? id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "installation/${id}/workupdates/tasklist",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];

      return data;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future serviceWorkTaskList(
    String? token,
    int? id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "service/${id}/workupdates/tasklist",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];

      return data;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future workProductList(
    String? token,
    int? id,
    int? taskId,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "installation/${id}/workupdates/taskproducts/${taskId}",
    );

    if (response.statusCode == 200) {
      response.data["data"];

      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future serviceWorkProductList(
    String? token,
    int? id,
    int? taskId,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "service/${id}/workupdates/taskproducts/${taskId}",
    );

    if (response.statusCode == 200) {
      response.data["data"];

      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future workUpadteLists(
    String? token,
    int? id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "installation/${id}/workupdates",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publicTask(String token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "tasks/list",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publicTaskView(String token, int id) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "tasks/${id}/view",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publicTaskStatus(String token, int id, String data) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.post("tasks/${id}/changestatus",
        data: jsonEncode({"status": data}));

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future BranchUsers(
    String token,
    int id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "tasks/${id}/getbranchusers",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publickGetExpense(
    String token,
    int id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "tasks/${id}/expenses",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publicBranchUsersReassign(
    String? token,
    int id,
    List<int> data,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final formData = FormData.fromMap({});

    for (var i = 0; i < data.length; i++)
      formData.fields.add(MapEntry("user_id[${i}]", data[i].toString()));

    Response response = await dio.post(
      "tasks/${id}/reassigntask",
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future publicExpenseAdd(
    String token,
    int id,
    Map<String, dynamic> data,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    final formData = FormData.fromMap({
      "amount": data["amount"],
      "category_id": data["category_id"],
      "expense_km": data["expense_km"],
      "notes": data["notes"],
      "attachment": data["attachment"] == null
          ? ""
          : await MultipartFile.fromFile(
              data["attachment"].path,
              filename: data["attachment"].path.split('/').last,
            ),
    });

    for (var i = 0; i < data.length; i++)
      formData.fields.add(MapEntry("user_id[${i}]", data[i].toString()));

    try {
      Response response = await dio.post(
        "tasks/${id}/submitexpenses",
        data: formData,
      );
      print("${response}");
      return response;
    } on DioError catch (e) {
      print("demoxx" + e.response.toString());
      return e.response;
    }
  }

  Future getComand(
    String token,
    int id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "tasks/${id}/commands",
    );

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future removeComand(String token, int id, int cid) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    print("tasks/${id}/removecommands/${cid}");

    Response response = await dio.get("tasks/${id}/removecommands/${cid}");

    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future removeExpense(String token, int id, int cid) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get("tasks/${id}/removeexpense/${cid}");
      return response;
    } on DioError catch (e) {
      print("remove" + e.response.toString());
      return e.response;
    }
  }

  Future submitComand(
    String token,
    int id,
    String data,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    final formData = FormData.fromMap({"comment": data});

    try {
      Response response = await dio.post(
        "tasks/${id}/submitcommands",
        data: formData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  //Addendence

  Future leaveDuration(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "leaves/duration",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future leaveType(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "leaves/leavetypes",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future addLeave(
      String token,
      int _leaveType,
      String _leaveDuration,
      String reason,
      DateTime? selectedDate,
      List<DateTime>? selectedDateList) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final formData = FormData.fromMap({
      "leave_type_id": _leaveType.toString(),
      "duration": _leaveDuration,
      // "leave_date":selectedDate==null?selectedDateList:DateFormat("dd-MM-yyyy").format(selectedDate),
      "reason": reason.isEmpty ? "--" : reason
    });
    if (_leaveDuration == "multiple") {
      var multidata = "";
      for (var i = 0; i < selectedDateList!.length; i++) {
        print(DateFormat("dd-MM-yyyy").format(selectedDateList[i]));

        multidata += DateFormat("dd-MM-yyyy").format(selectedDateList[i]) + ",";
      }
      multidata = multidata.substring(0, multidata.length - 1);
      formData.fields.add(MapEntry("multi_date", multidata));
    } else {
      formData.fields.add(MapEntry(
          "leave_date", DateFormat("dd-MM-yyyy").format(selectedDate!)));
    }

    try {
      Response response = await dio.post("leaves/request", data: formData);
      print(response.toString());
      return response;
    } on DioError catch (e) {
      print(e.response.toString());

      return e.response;
    }
  }

  Future addPermission(String token, String toTime, String fromTime,
      String date, String reason, int id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    final formData = FormData.fromMap({
      "date": date,
      "user_id": id,
      "from_time": fromTime,
      "to_time": toTime,
      "reason": reason.isEmpty ? "--" : reason
    });

    try {
      Response response = await dio.post("permission/request", data: formData);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getBonus(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "dashboard/bonusamt",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getAbsentList(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "dashboard/absentdays",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getPresentList(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "dashboard/presentdays",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getAchivement(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "dashboard/targetachieved",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getAllExpense(
    String token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "expenses",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getHoliday(String token, String year, String month) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "dashboard/holidays/${year}/${month}",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getActiveTimer(String token, int taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "tasks/${taskId}/getactivetimer",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future startTimer(String token, int taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "tasks/${taskId}/starttimer",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future stopTimer(String token, int taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "tasks/${taskId}/stoptimer",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future pauseTimer(String token, int taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "tasks/pausetimer/${taskId}",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future resumeTimer(String token, int taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "tasks/resumetimer/${taskId}",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getWorkUpdateDetails(
    String token,
    int id,
    int taskId,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "installation/${id}/workupdates/${taskId}/show",
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future getServiceWorkUpdateDetails(
    String token,
    int id,
    int taskId,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await dio.get(
        "service/${id}/workupdates/${taskId}/show",
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
    print(response.toString());
    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(response.data["data"]);
      print(user.toString());
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

  Future<List<ServiceListModel>> ServiceModelList(String? token) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "service/list",
    );

    print(response.toString());
    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ServiceListModel> services = [];
      data.map((e) {
        services.add(ServiceListModel.fromJson(e));
      }).toList();
      return services;
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

  Future<ServiceDetailsModel> ServiceOverView(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "service/list/${id}",
    );
    if (response.statusCode == 200) {
      ServiceDetailsModel overView =
          ServiceDetailsModel.fromJson(response.data["data"]);
      return overView;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<MemberModel>> Members(
    String? token,
    int? id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
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

  Future<List<ServiceMemberModel>> ServiceMembers(
    String? token,
    int? id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "service/${id}/assigned",
    );
    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ServiceMemberModel> members = [];
      data.map((e) {
        members.add(ServiceMemberModel.fromJson(e));
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
      List<FileModel> files = [];
      data.map((e) {
        files.add(FileModel.fromJson(e));
      }).toList();
      return files;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<ServiceFileModel>> ServiceFiles(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "service/${id}/files",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ServiceFileModel> files = [];
      data.map((e) {
        files.add(ServiceFileModel.fromJson(e));
      }).toList();
      return files;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<ExpensesModel>> Expenses(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/${id}/expenses",
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

  Future<List<SeviceExpenseModel>> ServiceExpenses(
      String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "service/${id}/expenses",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<SeviceExpenseModel> tasks = [];
      data.map((e) {
        tasks.add(SeviceExpenseModel.fromJson(e));
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

  Future<List<WorkUpdateMode>> WorkUpdate(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/$id/workupdate/list",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      print("new" + data.toString());
      List<WorkUpdateMode> tasks = [];
      data.map((e) {
        tasks.add(WorkUpdateMode.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<InstallationTaskModel>> instalationTask(
      String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/${id}/tasks",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<InstallationTaskModel> tasks = [];
      data.map((e) {
        tasks.add(InstallationTaskModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<ServiceTaskModel>> serviceTask(String? token, int? id) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "service/${id}/tasks",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ServiceTaskModel> tasks = [];
      data.map((e) {
        tasks.add(ServiceTaskModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<InstallationTaskDetailsModel> instalationTaskDetails(
      String? token, int? id, int? taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get(
      "installation/${id}/task/${taskId}/show",
    );

    if (response.statusCode == 200) {
      InstallationTaskDetailsModel tasks =
          InstallationTaskDetailsModel.fromJson(response.data["data"]);

      print(tasks.toJson().toString());

      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<ServiceTaskDetailsModel> serviceTaskDetails(
      String? token, int? id, int? taskId) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    print("--${"service/${id}/task/${taskId}/show"}");
    Response response = await dio.get(
      "service/${id}/task/${taskId}/show",
    );

    if (response.statusCode == 200) {
      ServiceTaskDetailsModel tasks =
          ServiceTaskDetailsModel.fromJson(response.data["data"]);

      print(tasks.toJson().toString());

      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<InstallationEmployeeModel>> workParticipants(
      String? token, int? id, String? date) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    print("installation/${id}/workupdates/participants/${date}");
    Response response = await dio.get(
      "installation/${id}/workupdates/participants/${date}",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<InstallationEmployeeModel> tasks = [];
      data.map((e) {
        tasks.add(InstallationEmployeeModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<InstallationWorkUpdateListModel>> workUpadteLists(
    String? token,
    int? id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "installation/${id}/workupdates",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<InstallationWorkUpdateListModel> tasks = [];
      data.map((e) {
        tasks.add(InstallationWorkUpdateListModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<ServiceWorkupdateListModel>> serviceWorkUpdateLists(
    String? token,
    int? id,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "service/${id}/workupdates",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<ServiceWorkupdateListModel> tasks = [];
      data.map((e) {
        tasks.add(ServiceWorkupdateListModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<LeaveListModel>> leaveList(
    String? token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "leaves",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<LeaveListModel> tasks = [];
      data.map((e) {
        tasks.add(LeaveListModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<PermissionListModel>> permissionList(
    String? token,
  ) async {
    dio.options.headers["Authorization"] = "Bearer $token";

    Response response = await dio.get(
      "permission",
    );

    if (response.statusCode == 200) {
      List data = response.data["data"];
      List<PermissionListModel> tasks = [];
      data.map((e) {
        tasks.add(PermissionListModel.fromJson(e));
      }).toList();
      return tasks;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}

final provider = Provider<ProviderApi>((red) => ProviderApi());

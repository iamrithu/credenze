import 'package:credenze/apis/api.dart';
import 'package:credenze/models/expense-category-model.dart';
import 'package:credenze/models/expenses-model.dart';
import 'package:credenze/models/file-model.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/installation-overview-model.dart';
import 'package:credenze/models/members_model.dart';
import 'package:credenze/models/task-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/instalation-task-details-model.dart';
import '../models/instalation-task-model.dart';
import '../models/installation-employee-model.dart';
import '../models/installation-work-updatedList-model.dart';
import '../models/work-update-model.dart';

final newToken = StateProvider<String?>((ref) => "");
final selectedDate = StateProvider<String?>(
    (ref) => DateFormat("dd-MM-yyyy").format(DateTime.now()));
final workSelectedDate = StateProvider<String?>((ref) => "select date");
final demo = StateProvider<String?>((ref) => "demo");

final pageIndex = StateProvider<int>((ref) => 0);
final userId = StateProvider<int>((ref) => 0);
final netWorkConnectivity = StateProvider<bool>((ref) => true);
final InstallationClockIn = StateProvider<bool>((ref) => true);
final Installavailable = StateProvider<bool>((ref) => true);

final overViewId = StateProvider<int>((ref) => 0);
final taskId = StateProvider<int>((ref) => 0);

final inChargeId = StateProvider<int>((ref) => 0);

final userDataProvider = FutureProvider<UserModel>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).UserData(token);
});
final userInstallationProvider = FutureProvider<List<InstallationModel>>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).InstalationModel(token);
});
final userInstallationListProvider =
    FutureProvider<List<InstallationModel>>((ref) {
  String? token = ref.watch(newToken);
  String? date = ref.watch(selectedDate);

  return ref.watch(provider).InstalationModelList(token, date);
});

final InsttalationOverVIewProvider =
    FutureProvider<InstallationOverViewModel>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);
  return ref.watch(provider).InstallationOverView(token, id);
});
final membersProvider = FutureProvider<List<MemberModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);
  int? userCheckid = ref.watch(userId);

  return ref.watch(provider).Members(token, id, userCheckid!);
});
final taskProvider = FutureProvider<List<TaskModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).Tasks(token, id);
});
final installationTaskProvider =
    FutureProvider<List<InstallationTaskModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).instalationTask(token, id);
});
final installationTaskDetailsProvider =
    FutureProvider<InstallationTaskDetailsModel>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);
  int? task = ref.watch(taskId);

  return ref.watch(provider).instalationTaskDetails(token, id, task);
});
final expenseProvider = FutureProvider<List<ExpensesModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).Expenses(token, id);
});
final expenseCategoryProvider =
    FutureProvider<List<ExpenseCategoryModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).ExpensesCategory(token, id);
});
final fileProvider = FutureProvider<List<FileModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).Files(token, id);
});

final workUpdateProvider = FutureProvider<List<WorkUpdateMode>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).WorkUpdate(token, id);
});
final workUpdateEmployeeProvider =
    FutureProvider<List<InstallationEmployeeModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);
  String? date = ref.watch(workSelectedDate);

  return ref.watch(provider).workParticipants(token, id, date!);
});

final workUpdateListProvider =
    FutureProvider<List<InstallationWorkUpdateListModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).workUpadteLists(
        token,
        id,
      );
});

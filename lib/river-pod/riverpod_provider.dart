import 'package:credenze/apis/api.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/installation-overview-model.dart';
import 'package:credenze/models/members_model.dart';
import 'package:credenze/models/task-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newToken = StateProvider<String?>((ref) => "");
final pageIndex = StateProvider<int>((ref) => 0);
final userId = StateProvider<int>((ref) => 0);
final netWorkConnectivity = StateProvider<bool>((ref) => true);
final InstallationClockIn = StateProvider<bool>((ref) => true);
final overViewId = StateProvider<int>((ref) => 0);
final userDataProvider = FutureProvider<UserModel>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).UserData(token);
});
final userInstallationProvider = FutureProvider<List<InstallationModel>>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).InstalationModel(token);
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

  return ref.watch(provider).Members(token, id);
});
final taskProvider = FutureProvider<List<TaskModel>>((ref) {
  String? token = ref.watch(newToken);
  int? id = ref.watch(overViewId);

  return ref.watch(provider).Tasks(token, id);
});

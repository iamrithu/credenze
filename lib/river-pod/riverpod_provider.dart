import 'package:credenze/apis/api.dart';
import 'package:credenze/models/installation-list-model.dart';
import 'package:credenze/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newToken = StateProvider<String?>((ref) => "");

final userDataProvider = FutureProvider<UserModel>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).UserData(token);
});
final userInstallationProvider = FutureProvider<List<InstallationModel>>((ref) {
  String? token = ref.watch(newToken);
  return ref.watch(provider).InstalationModel(token);
});

final pageIndex = StateProvider<int>((ref) => 0);
final netWorkConnectivity = StateProvider<bool>((ref) => true);

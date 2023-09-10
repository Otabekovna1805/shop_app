import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/user_model.dart';

class HiveUser {
  static String todoDb = 'userDb';
  static String todos = 'users';
  static String currentUser = 'currentUser';
  static String user = 'user';

  static Box<List> box = Hive.box(todoDb);
  static Box<Map> currentUserBox = Hive.box(currentUser);

  static Future<void> init() async {
    await Hive.initFlutter();
    if(!Hive.isBoxOpen(todoDb)) {
      await Hive.openBox<List>(todoDb);
    }
    if(!Hive.isBoxOpen(currentUser)) {
      await Hive.openBox<Map>(currentUser);
    }
  }

  Future<void> storeDara(User user) async {
    List<Map<String, Object?>> response = getData;
    response.add(user.toJson());
    await box.put(todos, response);
  }

  Future<void> deleteData(int id) async {
    List<Map<String, Object?>> response = getData;
    response.removeWhere((element) => (element['id'] as int) == id);
    await box.put(todos, response);
  }

  ValueListenable<Box<List>> get getListenable => box.listenable();

  List<Map<String, Object?>> get getData {
    final data = box.get(todos) ?? [];
    return data.map((e) => Map<String, Object?>.from(e)).toList();
}

Future<void> saveUser(User loginUser) async {
    await currentUserBox.put(user, loginUser.toJson());
}

Map<String, Object?>? getUser() {
    final data = currentUserBox.get(user);
    if(data == null) return null;
    return Map<String, Object?>.from(data);
}

Future<void> clearUser() async {
    await currentUserBox.delete(user);
}

}
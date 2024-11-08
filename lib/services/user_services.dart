import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/transaction.dart';
import '../entities/user.dart';
import '../services/shared_services.dart';
import '../model/user_model.dart';
import 'isar_services.dart';

class UserServices extends IsarServices {
  Future<void> insertUser() async {
    final isar = await db;
    final existUser = await isar.users.where().isEmpty();
    if (existUser == true) {
      isar.writeTxn(
        () async {
          for (var user in userList) {
            final newUser = User()
              ..name = user.name
              ..password = user.password
              ..email = user.email
              ..hobby = user.hobby
              ..wallet = user.wallet
              ..createBy = user.createBy
              ..createAt = user.createAt
              ..updateBy = user.updateBy
              ..updateAt = user.updateAt;

            await isar.users.put(newUser);
          }
        },
      );
    }
  }

  Future<User?> signInUser(String email, String password) async {
    final isar = await db;

    final existUser =
        isar.users.filter().emailEqualTo(email).and().passwordEqualTo(password);
    if (kDebugMode) {
      print('New User: $email, $password');
    }
    if (await existUser.isNotEmpty()) {
      return existUser.findFirst();
    } else {
      return null;
    }
  }

  Future<bool> signUpUser(
      String email, String name, String password, String hobby) async {
    final isar = await db;

    final newUser = User()
      ..name = name
      ..email = email
      ..password = password
      ..hobby = hobby
      ..wallet = 0
      ..createBy = name
      ..createAt = DateTime.now()
      ..updateBy = name
      ..updateAt = DateTime.now();

    final validation = isar.users.filter().emailEqualTo(email);
    if (kDebugMode) {
      print('New User: $name, $email, $password, $hobby');
    }
    if (await validation.isEmpty()) {
      await isar.writeTxn(() async {
        await isar.users.put(newUser);
      });
      if (kDebugMode) {
        print('$email tidak ada di database');
      }
      return true;
    }
    if (kDebugMode) {
      print('$email  ada di database');
    }
    return false;
  }

  void showUser() async {
    final isar = await db;
    final existUser = await isar.users.where().findAll();

    for (var user in existUser) {
      if (kDebugMode) {
        print(
            '${user.id}, ${user.email}, ${user.name}, ${user.password}, ${user.hobby}, ${user.wallet}, ${user.createBy}, ${user.createAt}, ${user.updateBy}, ${user.updateAt}');
      }
    }
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");
    final isar = await db;
    final user = await isar.users.get(userId!);
    return user;
  }

  Future<bool> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedServices sharedServices = SharedServices();
    final int? userId = prefs.getInt("userId");
    final isar = await db;

    showUser();
    isar.writeTxn(() async {
      await isar.transactions
          .filter()
          .user(
            (q) => q.idEqualTo(userId!),
          )
          .deleteAll();
      await isar.users.delete(userId!);
    });
    sharedServices.deleteCacheUser();
    return true;
  }

  Future<bool> updateUser(
    String? name,
    String? email,
    String? password,
    String? hobby,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");
    final isar = await db;
    final getUser = await isar.users.get(userId!);
    isar.writeTxn(() async {
      getUser?.name = name!.isEmpty ? getUser.name : name;
      getUser?.email = email!.isEmpty ? getUser.email : email;
      getUser?.password = password!.isEmpty ? getUser.password : password;
      getUser?.hobby = hobby!.isEmpty ? getUser.hobby : hobby;
      getUser?.updateBy = name!.isEmpty ? getUser.name : name;
      getUser?.updateAt = DateTime.now();
      await isar.users.put(getUser!);
    });

    return true;
  }
}

List<UserModel> userList = [
  UserModel(
    name: "admin",
    email: "admin@admin.com",
    password: "admin",
    hobby: "Jadi admin",
    wallet: 0,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  UserModel(
    name: "irfan",
    email: "irfan@gmail.com",
    password: "shinigami",
    hobby: "Game",
    wallet: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
];

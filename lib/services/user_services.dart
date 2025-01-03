import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/transaction.dart';
import '../entities/user.dart';
import '../services/shared_services.dart';
import 'isar_services.dart';

class UserServices extends IsarServices {
  Future<void> insertUser() async {
    final isar = await db;
    final existUser = await isar.users.where().isEmpty();
    if (existUser) {
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
      print('New User: Email $email, Password $password');
    }
    if (await existUser.isNotEmpty()) {
      return existUser.findFirst();
    } else {
      return null;
    }
  }

  Future<bool> signUpUser(
    String email,
    String name,
    String password,
    String hobby,
  ) async {
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

    if (kDebugMode) {
      for (var user in existUser) {
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
    final SharedServices sharedServices = SharedServices();
    final userData = await getUser();
    final isar = await db;
    if (userData != null) {
      isar.writeTxn(() async {
        await isar.transactions
            .filter()
            .user(
              (q) => q.idEqualTo(userData.id),
            )
            .deleteAll();
        await isar.users.delete(userData.id);
      });
      showUser();
      sharedServices.deleteCacheUser();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(
    String? name,
    String? email,
    String? password,
    String? hobby,
    double? wallet,
  ) async {
    final isar = await db;
    final userData = await getUser();

    isar.writeTxn(() async {
      if (userData != null) {
        userData.name = name!.isEmpty ? userData.name : name;
        userData.email = email!.isEmpty ? userData.email : email;
        userData.password = password!.isEmpty ? userData.password : password;
        userData.hobby = hobby!.isEmpty ? userData.hobby : hobby;
        userData.wallet = userData.wallet + wallet!;
        userData.updateBy = name.isEmpty ? userData.name : name;
        userData.updateAt = DateTime.now();
        await isar.users.put(userData);
      }
    });

    return true;
  }
}

// Random Price
double randomWallet() {
  const double maxPrince = 9000001;
  double value = Random().nextDouble() * maxPrince;
  double wallet = double.parse(value.toStringAsFixed(0));
  return wallet;
}

List<User> userList = [
  User()
    ..name = "admin"
    ..email = "admin@admin.com"
    ..password = "admin"
    ..hobby = "Jadi admin"
    ..wallet = randomWallet()
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  User()
    ..name = "irfan"
    ..email = "irfan@admin.com"
    ..password = "s"
    ..hobby = "Jadi admin"
    ..wallet = randomWallet()
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
];

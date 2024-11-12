import 'package:isar/isar.dart';

import 'transaction.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String name;

  late String email;

  late String password;

  late String hobby;

  late double wallet;

  late String createBy;

  late DateTime createAt;

  late String updateBy;

  late DateTime updateAt;

  final transactions = IsarLinks<Transaction>();
}

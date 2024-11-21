import 'package:isar/isar.dart';

import 'transaction.dart';

part 'destination.g.dart';

@collection
class Destination {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String imageTitle;

  late List<int> imageData;

  late String name;

  late String location;

  late double rating;

  late int price;

  late String createBy;

  late DateTime createAt;

  late String updateBy;

  late DateTime updateAt;

  final transactions = IsarLinks<Transaction>();
}

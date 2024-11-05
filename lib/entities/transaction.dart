import 'package:isar/isar.dart';

import 'destination.dart';
import 'user.dart';

part 'transaction.g.dart';

@Collection()
class Transaction {
  Id id = Isar.autoIncrement;
  late int amountOfTraveler;
  late String selectedSeat;
  late bool insurance;
  late bool refundable;
  late double vat;
  late int price;
  late double grandTotal;
  late String status;
  late String paymentNMethod;
  late String createBy;
  late DateTime createAt;
  late String updateBy;
  late DateTime updateAt;

  @Backlink(to: "transactions")
  final user = IsarLink<User>();

  @Backlink(to: "transactions")
  final destination = IsarLink<Destination>();
}

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'destination_services.dart';
import 'user_services.dart';
import '../entities/destination.dart';
import '../entities/transaction.dart';
import '../entities/user.dart';
import 'isar_services.dart';

class TransactionServices extends IsarServices {
  void insertTransaction() async {
    final isar = await openDb();
    final dummyUser = User()
      ..email = "asaka@gmail.com"
      ..name = "Asaka"
      ..password = "s"
      ..hobby = "anime"
      ..wallet = 1000000
      ..createBy = "admin"
      ..createAt = DateTime.now()
      ..updateBy = "admin"
      ..updateAt = DateTime.now();
    final dummyDestination = Destination()
      ..imageUrl = "assets/image_destination_8.png"
      ..name = "Roma"
      ..location = "Italy"
      ..rating = 4.8
      ..price = 1000000
      ..createBy = "admin"
      ..createAt = DateTime.now()
      ..updateBy = "admin"
      ..updateAt = DateTime.now();
    final dummyTransaction = Transaction()
      ..amountOfTraveler = 1
      ..selectedSeat = "2B"
      ..insurance = true
      ..refundable = false
      ..vat = 0.45
      ..price = 1000000
      ..grandTotal = 1450000
      ..status = "Successed"
      ..paymentNMethod = "Virtual account"
      ..createBy = "admin"
      ..createAt = DateTime.now()
      ..updateBy = "admin"
      ..updateAt = DateTime.now()
      ..user.value = dummyUser
      ..destination.value = dummyDestination;
    final existTransaction = await isar.transactions.where().isEmpty();
    if (existTransaction) {
      await isar.writeTxn(
        () async {
          await isar.users.put(dummyUser);
          await isar.destinations.put(dummyDestination);
          await isar.transactions.put(dummyTransaction);
          await dummyTransaction.user.save();
          await dummyTransaction.destination.save();
        },
      );
    }
  }

  Future<List<Transaction?>> getListTransaction() async {
    final isar = await db;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");
    final findTransaction = await isar.transactions
        .filter()
        .user(
          (q) => q.idEqualTo(userId!),
        )
        .findAll();
    showExistTransaction();
    return findTransaction;
  }

  Future<Transaction?> getTransaction(Id transactionId) async {
    final isar = await db;
    final existTransaction =
        await isar.transactions.filter().idEqualTo(transactionId).findFirst();
    return existTransaction;
  }

  void showTransactionById(Id transactionId) async {
    final isar = await db;
    final transaction =
        await isar.transactions.filter().idEqualTo(transactionId).findFirst();

    if (kDebugMode) {
      print(
          "All Transaction: user id = ${transaction!.user.value?.id}, user name = ${transaction.user.value?.name}, destination id = ${transaction.destination.value?.id}, destination name = ${transaction.destination.value?.name}, transaction id = ${transaction.id}, seat = ${transaction.selectedSeat}");
    }
  }

  void showExistTransaction() async {
    final isar = await db;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");

    final existTransaction = await isar.transactions
        .filter()
        .user(
          (q) => q.idEqualTo(userId!),
        )
        .findAll();
    if (kDebugMode) {
      if (existTransaction.isEmpty) {
        print("There is no transaction data for this account");
      } else {
        for (var transaction in existTransaction) {
          print(
              "Exist Transaction: user id = ${transaction.user.value?.id}, user name = ${transaction.user.value?.name}, destination id = ${transaction.destination.value?.id}, destination name = ${transaction.destination.value?.name}, transaction id = ${transaction.id}, seat = ${transaction.selectedSeat}");
        }
      }
    }
  }

  Future<bool> addTransaction(
    int amountOfTraveler,
    String selectedSeat,
    bool insurance,
    bool refundable,
    double vat,
    int price,
    double grandTotal,
    Id destinationId,
    String paymentMethod,
  ) async {
    UserServices userServices = UserServices();
    DestinationServices destinationServices = DestinationServices();
    final isar = await db;
    final getUser = await userServices.getUser();
    final getDestination =
        await destinationServices.getDestination(destinationId);
    final transaction = Transaction()
      ..amountOfTraveler = amountOfTraveler
      ..selectedSeat = selectedSeat
      ..insurance = insurance
      ..refundable = refundable
      ..vat = vat
      ..price = price
      ..grandTotal = grandTotal
      ..status = "Successed"
      ..paymentNMethod = paymentMethod
      ..createBy = getUser!.name
      ..createAt = DateTime.now()
      ..updateBy = getUser.name
      ..updateAt = DateTime.now()
      ..user.value = getUser
      ..destination.value = getDestination;
    await isar.writeTxn(
      () async {
        await isar.transactions.put(transaction);
        await transaction.user.save();
        await transaction.destination.save();
      },
    );
    showExistTransaction();
    return true;
  }

  Future<bool> cancelTransaction(Id transactionId) async {
    UserServices userServices = UserServices();
    final Isar isar = await db;
    final dataUser = await userServices.getUser();
    final cancelTransaction = await isar.transactions
        .filter()
        .user((q) => q.idEqualTo(dataUser!.id))
        .and()
        .idEqualTo(transactionId)
        .and()
        .statusEqualTo("Successed")
        .findFirst();
    showTransactionById(transactionId);
    if (cancelTransaction != null) {
      await isar.writeTxn(() async {
        cancelTransaction.status = "Canceled";
        cancelTransaction.updateBy = dataUser!.name;
        cancelTransaction.updateAt = DateTime.now();
        await isar.transactions.put(cancelTransaction);
      });
    }
    return true;
  }

  Future<bool> deleteTransaction(Id transactionId) async {
    UserServices userServices = UserServices();
    final Isar isar = await db;
    final userData = await userServices.getUser();
    final existTransaction = await isar.transactions
        .filter()
        .user(
          (q) => q.idEqualTo(userData!.id),
        )
        .and()
        .idEqualTo(transactionId)
        .and()
        .statusEqualTo("Canceled")
        .deleteAll();
    await isar.writeTxn(() async {
      existTransaction;
    });
    return true;
  }
}

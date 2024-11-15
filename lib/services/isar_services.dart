import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/destination.dart';
import '../entities/transaction.dart';
import '../entities/user.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserSchema, DestinationSchema, TransactionSchema],
        directory: dir.path,
        inspector: true,
        name: "database",
      );
    } else {
      final isarInstance = Isar.getInstance("database");
      if (isarInstance != null) {
        return Future.value(isarInstance);
      } else {
        throw Exception("Failed to initialize the database.");
      }
    }

    /*return Future.value(Isar.getInstance());*/
  }

  Future<void> deleteAllData() async {
    final isar = await db;
    final adminExist = await isar.users
        .filter()
        .nameEqualTo("admin")
        .and()
        .emailEqualTo("admin@admin.com")
        .findAll();

    if (adminExist.isEmpty) {
      await isar.writeTxn(
        () async {
          await isar.transactions.where().deleteAll();
          await isar.users.where().deleteAll();
          await isar.destinations.where().deleteAll();
        },
      );
    }
  }
}

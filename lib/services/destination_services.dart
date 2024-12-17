import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';

import '../entities/destination.dart';
import '../entities/transaction.dart';
import 'isar_services.dart';

class DestinationServices extends IsarServices {
  Future<void> insertDestination() async {
    final isar = await db;
    final existDestination = await isar.destinations.where().isEmpty();
    List<Destination> destinationList = [
      Destination()
        ..imageTitle = "image_destination_1"
        ..imageData =
            await convertImageFileToList("assets/image_destination_1.png")
        ..name = "Lake Ciliwung"
        ..location = "Tangerang"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_2"
        ..imageData =
            await convertImageFileToList("assets/image_destination_2.png")
        ..name = "White Houses"
        ..location = "Spain"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_3"
        ..imageData =
            await convertImageFileToList("assets/image_destination_3.png")
        ..name = "Hill Heyo"
        ..location = "Monaco"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_4"
        ..imageData =
            await convertImageFileToList("assets/image_destination_4.png")
        ..name = "Temple"
        ..location = "Japan"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_5"
        ..imageData =
            await convertImageFileToList("assets/image_destination_5.png")
        ..name = "Payung Teduh"
        ..location = "Indonesia"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_6"
        ..imageData =
            await convertImageFileToList("assets/image_destination_6.png")
        ..name = "Danau Beratan"
        ..location = "Singajara"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_7"
        ..imageData =
            await convertImageFileToList("assets/image_destination_7.png")
        ..name = "Sydney Opera"
        ..location = "Australia"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
      Destination()
        ..imageTitle = "image_destination_8"
        ..imageData =
            await convertImageFileToList("assets/image_destination_8.png")
        ..name = "Roma"
        ..location = "Italy"
        ..rating = randomRating()
        ..price = randomPrice()
        ..createAt = DateTime.now()
        ..createBy = "admin"
        ..updateAt = DateTime.now()
        ..updateBy = "admin",
    ];
    if (existDestination) {
      isar.writeTxn(
        () async {
          for (var destination in destinationList) {
            final newDestination = Destination()
              ..imageTitle = destination.imageTitle
              ..imageData = destination.imageData
              ..name = destination.name
              ..rating = destination.rating
              ..location = destination.location
              ..price = destination.price
              ..createBy = destination.createBy
              ..createAt = destination.createAt
              ..updateBy = destination.updateBy
              ..updateAt = destination.updateAt;
            await isar.destinations.put(newDestination);
          }
        },
      );
    }
  }

  Future<List<Destination>> getListDestination(String sort) async {
    final isar = await db;
    final allDestination = await isar.destinations.where().findAll();

    // Sort
    final sortPriceAsc =
        await isar.destinations.where().sortByPrice().findAll();
    final sortPriceDesc =
        await isar.destinations.where().sortByPriceDesc().findAll();

    final sortNameAsc = await isar.destinations.where().sortByName().findAll();
    final sortNameDesc =
        await isar.destinations.where().sortByNameDesc().findAll();

    final sortLocationAsc =
        await isar.destinations.where().sortByLocation().findAll();
    final sortLocationDesc =
        await isar.destinations.where().sortByLocationDesc().findAll();

    final sortRatingAsc =
        await isar.destinations.where().sortByRating().findAll();

    final sortRatingDesc =
        await isar.destinations.where().sortByRatingDesc().findAll();

    Map<String, dynamic> sortMap = {
      "allDestination": allDestination,
      "sortPriceAsc": sortPriceAsc,
      "sortPriceDesc": sortPriceDesc,
      "sortNameAsc": sortNameAsc,
      "sortNameDesc": sortNameDesc,
      "sortLocationAsc": sortLocationAsc,
      "sortLocationDesc": sortLocationDesc,
      "sortRatingAsc": sortRatingAsc,
      "sortRatingDesc": sortRatingDesc,
    };
    final List<Destination> destinations = sortMap[sort];

    if (kDebugMode) {
      for (var get in destinations) {
        print(
            "Show $sort list ${get.id}, ${get.name}, ${get.createBy}, ${get.createAt}, ${get.updateBy}, ${get.updateAt}");
      }
    }
    return destinations;
  }

  Future<Destination?> getDestination(Id id) async {
    final isar = await db;
    final destination = await isar.destinations.get(id);
    showDestination(destination!.id);
    return destination;
  }

  void showListDestination() async {
    final isar = await db;
    final existDestinations = await isar.destinations.where().findAll();
    for (var get in existDestinations) {
      if (kDebugMode) {
        print(
            "Show all destinations ${get.id}, ${get.name}, ${get.createBy}, ${get.createAt}, ${get.updateBy}, ${get.updateAt}");
      }
    }
  }

  void showDestination(Id destinationId) async {
    final isar = await db;
    final existDestinations =
        await isar.destinations.where().idEqualTo(destinationId).findFirst();
    if (kDebugMode) {
      if (existDestinations != null) {
        print(
            "Show destination ${existDestinations.id}, ${existDestinations.name}, ${existDestinations.createBy}, ${existDestinations.createAt}, ${existDestinations.updateBy}, ${existDestinations.updateAt}");
      }
    }
  }

  Future<bool> deleteDestination(Id destinationId) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.transactions
          .filter()
          .destination((q) => q.idEqualTo(destinationId))
          .deleteAll();
      await isar.destinations.delete(destinationId);
    });

    return true;
  }
}

// Random Price
int randomPrice() {
  const int maxPrince = 9000001;
  const int minPrice = 1000000;
  int price = Random().nextInt(maxPrince) + minPrice;
  return price;
}

// Random Rating
double randomRating() {
  const double maxRating = 5.0;
  double value = Random().nextDouble() * maxRating;
  double rating = double.parse(value.toStringAsFixed(1));
  return rating;
}

Future<List<int>> convertImageFileToList(String imagePath) async {
  try {
    final ByteData data = await rootBundle.load(imagePath);
    Uint8List uint8Data = data.buffer.asUint8List();
    return uint8Data.toList();
  } catch (e) {
    if (kDebugMode) {
      print("Error loading asset: $e");
    }
    return Uint8List(0);
  }
}

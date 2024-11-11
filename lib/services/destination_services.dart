import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../entities/destination.dart';
import 'isar_services.dart';

class DestinationServices extends IsarServices {
  Future<void> insertDestination() async {
    final isar = await db;
    final existDestination = await isar.destinations.where().isEmpty();
    if (existDestination) {
      isar.writeTxn(
        () async {
          for (var destination in destinationList) {
            final newDestination = Destination()
              ..imageUrl = destination.imageUrl
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

  Future<List<Destination>> getListDestination() async {
    final isar = await db;
    final existDestination = await isar.destinations.where().findAll();
    return existDestination;
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
}

// Random Price
const int maxPrince = 9000001;
const int minPrice = 1000000;
int randomPrice = Random().nextInt(maxPrince) + minPrice;

// Random Rating
const double maxRating = 5.0;
double value = Random().nextDouble() * maxRating;
double randomRating = double.parse(value.toStringAsFixed(1));

List<Destination> destinationList = [
  Destination()
    ..imageUrl = "assets/image_destination_1.png"
    ..name = "Lake Ciliwung"
    ..location = "Tangerang"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_2.png"
    ..name = "White Houses"
    ..location = "Spain"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_3.png"
    ..name = "Hill Heyo"
    ..location = "Monaco"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_4.png"
    ..name = "Temple"
    ..location = "Japan"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_5.png"
    ..name = "Payung Teduh"
    ..location = "Indonesia"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_6.png"
    ..name = "Danau Beratan"
    ..location = "Singajara"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_7.png"
    ..name = "Sydney Opera"
    ..location = "Australia"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
  Destination()
    ..imageUrl = "assets/image_destination_8.png"
    ..name = "Roma"
    ..location = "Italy"
    ..rating = randomRating
    ..price = randomPrice
    ..createAt = DateTime.now()
    ..createBy = "admin"
    ..updateAt = DateTime.now()
    ..updateBy = "admin",
];

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

  Future<List<Destination>> getListDestination(String sort) async {
    final isar = await db;
    final allDestination = await isar.destinations.where().findAll();

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

    Map<String, dynamic> sortMap = {
      "allDestination": allDestination,
      "sortPriceAsc": sortPriceAsc,
      "sortPriceDesc": sortPriceDesc,
      "sortNameAsc": sortNameAsc,
      "sortNameDesc": sortNameDesc,
      "sortLocationAsc": sortLocationAsc,
      "sortLocationDesc": sortLocationDesc,
    };
    final List<Destination> destinations = sortMap[sort];
    if (kDebugMode) {
      for (var get in destinations) {
        print(
            "Show all destinations ${get.id}, ${get.name}, ${get.createBy}, ${get.createAt}, ${get.updateBy}, ${get.updateAt}");
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

  Future<List<Destination?>> sortDestinations(String sort) async {
    final Isar isar = await db;

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

    Map<String, dynamic> sortMap = {
      "sortPriceAsc": sortPriceAsc,
      "sortPriceDesc": sortPriceDesc,
      "sortNameAsc": sortNameAsc,
      "sortNameDesc": sortNameDesc,
      "sortLocationAsc": sortLocationAsc,
      "sortLocationDesc": sortLocationDesc,
    };
    final List<Destination> sortedDestinations = sortMap[sort];
    if (kDebugMode) {
      for (var get in sortedDestinations) {
        print(
            "Show all destinations ${get.id}, ${get.name}, ${get.createBy}, ${get.createAt}, ${get.updateBy}, ${get.updateAt}");
      }
    }
    return sortedDestinations;
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

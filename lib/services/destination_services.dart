import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../entities/destination.dart';
import '../model/destination_model.dart';
import 'isar_services.dart';

class DestinationServices extends IsarServices {
  Future<void> insertDestination() async {
    final isar = await db;
    final existDestination = await isar.destinations.where().isEmpty();
    if (existDestination == true) {
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

  Future<List<Destination>> getDestinations() async {
    final isar = await db;
    final existDestination = await isar.destinations.where().findAll();
    return existDestination;
  }

  Future<Destination?> getDestinationDetail(Id id) async {
    final isar = await db;
    final destination = await isar.destinations.get(id);
    return destination;
  }

  void showDestination() async {
    final isar = await db;
    final existDestinations = await isar.destinations.where().findAll();
    for (var get in existDestinations) {
      if (kDebugMode) {
        print(
            "${get.id}, ${get.name}, ${get.createBy}, ${get.createAt}, ${get.updateBy}, ${get.updateAt}");
      }
    }
  }
}

List<DestinationModel> destinationList = [
  DestinationModel(
    imageUrl: "assets/image_destination_1.png",
    name: "Lake Ciliwung",
    location: "Tangerang",
    rating: 4.8,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_2.png",
    name: "White Houses",
    location: "Spain",
    rating: 4.7,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_3.png",
    name: "Hill Heyo",
    location: "Monaco",
    rating: 4.8,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_4.png",
    name: "Temple",
    location: "Japan",
    rating: 5.0,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_5.png",
    name: "Payung Teduh",
    location: "Singapore",
    rating: 4.8,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_6.png",
    name: "Danau Beratan",
    location: "SingaJara",
    rating: 4.5,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_7.png",
    name: "Sydney Opera",
    location: "Australia",
    rating: 4.7,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
  DestinationModel(
    imageUrl: "assets/image_destination_8.png",
    name: "Roma",
    location: "Italy",
    rating: 4.8,
    price: 1000000,
    createBy: "admin",
    createAt: DateTime.now(),
    updateBy: "admin",
    updateAt: DateTime.now(),
  ),
];

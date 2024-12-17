import 'package:flutter/foundation.dart';

class SeatProvider extends ChangeNotifier {
  final List<String> seatNumber = [];

  void addSeatNumber(String seat) {
    seatNumber.add(seat);
    if (kDebugMode) {
      print("Provider: $seatNumber");
    }
    notifyListeners();
  }

  void removeSeatNumber(String seat) {
    seatNumber.remove(seat);
    if (kDebugMode) {
      print("Provider: $seatNumber");
    }
    notifyListeners();
  }

  void removeAllSeatNumber() {
    seatNumber.clear();
    notifyListeners();
  }
}

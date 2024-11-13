import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedServices {
  void cacheUserInfo(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  void deleteCacheUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  Future<void> alreadyAccessBonusPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool accessed = prefs.getBool("hasAccessedPage") ?? false;

    if (!accessed) {
      await prefs.setBool("hasAccessedPage", true);
    }
    if (kDebugMode) {
      if (!accessed) {
        print("Firts time in bonus page");
      } else {
        print("Not firts time in bonus page");
      }
    }
  }
}

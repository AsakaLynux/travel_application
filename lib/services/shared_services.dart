import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_services.dart';

class SharedServices {
  void cacheUserInfo(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  void deleteCacheUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");
  }

  void deleteCacheBonusPage() async {
    UserServices userServices = UserServices();
    final userData = await userServices.getUser();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("${userData!.id}hasAccessedPage");
  }

  Future<bool> alreadyAccessBonusPage() async {
    UserServices userServices = UserServices();
    final userData = await userServices.getUser();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool accessed = prefs.getBool("${userData!.id}hasAccessedPage") ?? false;

    if (!accessed) {
      await prefs.setBool("hasAccessedPage", true);
      if (kDebugMode) {
        print("Firts time in bonus page");
      }
      return false;
    }
    if (kDebugMode) {
      if (accessed) {
        print("Not firts time in bonus page");
      }
    }

    return true;
  }
}

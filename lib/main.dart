import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider/seat_provider.dart';
import 'services/destination_services.dart';
import 'services/isar_services.dart';
import 'services/transaction_services.dart';
import 'services/user_services.dart';
import 'shared/theme.dart';
import 'ui/pages/bonus_page.dart';
import 'ui/pages/check_out_page.dart';
import 'ui/pages/choose_seat_page.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/sign_in_page.dart';
import 'ui/pages/sign_up_page.dart';
import 'ui/pages/started_page.dart';
import 'ui/pages/success_checkout_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  deleteData();
  initializeData();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SeatProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      // home: const HomePage(),
      initialRoute: "/",
      routes: {
        "/": (context) => const StartedPage(),
        "/SuccessCheckOutPage": (context) => const SuccessCheckoutPage(),
        "/CheckOutPage": (context) => const CheckOutPage(),
        "/ChooseSeatPage": (context) => const ChooseSeatPage(),
        "/SignInPage": (context) => const SignInPage(),
        "/SignUpPage": (context) => const SignUpPage(),
        "/BonusPage": (context) => const BonusPage(),
        "/HomePage": (context) => const HomePage(),
      },
    );
  }
}

void initializeData() {
  UserServices userServices = UserServices();
  DestinationServices destinationServices = DestinationServices();
  TransactionServices transactionServices = TransactionServices();
  userServices.insertUser();
  destinationServices.insertDestination();
  transactionServices.insertTransaction();
}

void deleteData() {
  IsarServices isarServices = IsarServices();
  isarServices.deleteAllData();
}


/*
  note:
  1. If account already get in to bonus page, the account don't need to pass it again
  2. Check all file in lib folder to correcting import file
  3. Search a method to check if isar writetxt is success or failed
  4. Make transaction detail page
  5. Make admin page:
    a. Can add destination
    b. Can delete account
    c. Can delete transaction
  6. Make cancel transaction
  7. Add status in transaction intance with value "Successed" || "Failed" || "Canceled"
*/
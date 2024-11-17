import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel_application/ui/admin/pages/account_page.dart';
import 'package:travel_application/ui/admin/pages/admin_page.dart';
import 'package:travel_application/ui/admin/pages/destination_page.dart';
import 'package:travel_application/ui/admin/pages/transaction_page.dart';

import 'provider/seat_provider.dart';
import 'services/destination_services.dart';
import 'services/isar_services.dart';
import 'services/transaction_services.dart';
import 'services/user_services.dart';
import 'shared/theme.dart';
import 'ui/admin/pages/add_destination_page.dart';
import 'ui/user/pages/bonus_page.dart';
import 'ui/user/pages/check_out_page.dart';
import 'ui/user/pages/choose_seat_page.dart';
import 'ui/user/pages/home_page.dart';
import 'ui/user/pages/sign_in_page.dart';
import 'ui/user/pages/sign_up_page.dart';
import 'ui/user/pages/started_page.dart';
import 'ui/user/pages/success_checkout_page.dart';

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
        "/SignInPage": (context) => const SignInPage(),
        "/SignUpPage": (context) => const SignUpPage(),
        // Admin Page
        "/AdminPage": (context) => const AdminPage(),
        "/DestinationPage": (context) => const DestinationPage(),
        "/AddDestinationPage": (context) => const AddDestinationPage(),
        "/TransactionPage": (context) => const TransactionPage(),
        "AccountPage": (context) => const AccountPage(),
        // User Page
        "/BonusPage": (context) => const BonusPage(),
        "/HomePage": (context) => const HomePage(),
        "/ChooseSeatPage": (context) => const ChooseSeatPage(),
        "/CheckOutPage": (context) => const CheckOutPage(),
        "/SuccessCheckOutPage": (context) => const SuccessCheckoutPage(),
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

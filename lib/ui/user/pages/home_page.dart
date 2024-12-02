import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_application/model/sort_transaction_mode.dart';

import '../../../model/sort_destination_model.dart';
import 'transaction_detail_page.dart';
import '../../../widget/custom_transaction_tile.dart';
import '../../../services/transaction_services.dart';
import '../../../services/user_services.dart';
import '../../../services/shared_services.dart';
import '../../../services/destination_services.dart';
import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_destination_card.dart';
import '../../../widget/custom_destination_tile.dart';
import 'destination_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  bool obscure = true;
  SortDestinationModel? selectedSortDestinationMethod;
  SortTransactionMode? selectedSortTransactionMethod;
  String sortDestinationMethod = "allDestination";
  String sortTransactionMethod = "allTransaction";
  // Controller for user form
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController hobbyController = TextEditingController(text: "");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controller for add balance form
  final TextEditingController balanceController =
      TextEditingController(text: "");
  final GlobalKey<FormState> formBalanceKey = GlobalKey<FormState>();

  void _visiblePassword() {
    setState(() {
      if (obscure) {
        obscure = false;
      } else {
        obscure = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DestinationServices destinationServices = DestinationServices();
    UserServices userServices = UserServices();
    TransactionServices transactionServices = TransactionServices();
    SharedServices sharedServices = SharedServices();
    final fetchDestination =
        destinationServices.getListDestination(sortDestinationMethod);
    final fetchUserInfo = userServices.getUser();
    userServices.showUser();
    final fetchTransaction =
        transactionServices.getListTransaction(sortTransactionMethod);

    Widget homePage() {
      Widget header() {
        Widget destinationSortMethod() {
          return DropdownButton<SortDestinationModel>(
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
            value: selectedSortDestinationMethod,
            onChanged: (SortDestinationModel? newValue) {
              setState(() {
                selectedSortDestinationMethod = newValue;
                sortDestinationMethod = newValue!.sortMethod;
              });
            },
            items: sortDestinationMethodList.map(
              (SortDestinationModel item) {
                return DropdownMenuItem<SortDestinationModel>(
                  value: item,
                  child: Text(item.sortMethod),
                );
              },
            ).toList(),
          );
        }

        return Row(
          children: [
            FutureBuilder(
              future: fetchUserInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("No Data");
                } else {
                  return Container(
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hallo,\n${snapshot.data?.name}",
                          style: blackTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Where to fly today?",
                          style: greyTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            destinationSortMethod(),
          ],
        );
      }

      Widget cardDestination() {
        return FutureBuilder(
          future: fetchDestination,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text("No Data");
            } else {
              return SizedBox(
                height: 323,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DestinationDetailPage(),
                            settings: RouteSettings(
                              arguments: snapshot.data![index].id,
                            ),
                          ),
                        );
                      },
                      child: CustomDestinationCard(
                        image: snapshot.data![index].imageData,
                        title: snapshot.data![index].name,
                        location: snapshot.data![index].location,
                        rating: snapshot.data![index].rating,
                      ),
                    );
                  },
                ),
              );
            }
          },
        );
      }

      Widget listDestination() {
        return Expanded(
          child: FutureBuilder(
            future: fetchDestination,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text("No Data");
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DestinationDetailPage(),
                            settings: RouteSettings(
                              arguments: snapshot.data![index].id,
                            ),
                          ),
                        );
                      },
                      child: CustomDestinationTile(
                        imageData: snapshot.data![index].imageData,
                        name: snapshot.data![index].name,
                        location: snapshot.data![index].location,
                        rating: snapshot.data![index].rating,
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      }

      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              cardDestination(),
              Text(
                "New This Year",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              listDestination(),
            ],
          ),
        ),
      );
    }

    Widget walletPage() {
      Widget wallet() {
        return FutureBuilder(
          future: fetchUserInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Text("No Data");
            } else {
              return Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(34),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: light,
                                  ),
                                ),
                                Text(
                                  snapshot.data!.name,
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: medium,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icon_plane.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  "Pay",
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balance",
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: light,
                            ),
                          ),
                          Text(
                            formatRupiah.format(snapshot.data!.wallet),
                            style: whiteTextStyle.copyWith(
                              fontSize: 26,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      }

      Widget listTransaction() {
        return Expanded(
          child: FutureBuilder(
            future: fetchTransaction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text("No Data");
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionDetailPage(),
                          settings: RouteSettings(
                            arguments: snapshot.data![index]?.id,
                          ),
                        ),
                      );
                    },
                    child: CustomTransactionTile(
                      imageData:
                          snapshot.data![index]!.destination.value!.imageData,
                      name: snapshot.data![index]!.destination.value!.name,
                      location:
                          snapshot.data![index]!.destination.value!.location,
                      person: snapshot.data![index]!.amountOfTraveler,
                      grandTotal: snapshot.data![index]!.grandTotal,
                      status: snapshot.data![index]!.status,
                    ),
                  ),
                );
              }
            },
          ),
        );
      }

      Widget transactoinSortMethod() {
        return DropdownButton<SortTransactionMode>(
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
          value: selectedSortTransactionMethod,
          onChanged: (SortTransactionMode? newValue) {
            setState(() {
              selectedSortTransactionMethod = newValue;
              sortTransactionMethod = newValue!.sortMethod;
            });
          },
          items: sortTransactionMethodList.map(
            (SortTransactionMode item) {
              return DropdownMenuItem<SortTransactionMode>(
                value: item,
                child: Text(item.sortMethod),
              );
            },
          ).toList(),
        );
      }

      return SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wallet(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "History",
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  transactoinSortMethod(),
                ],
              ),
              const SizedBox(height: 10),
              listTransaction(),
            ],
          ),
        ),
      );
    }

    Widget profilePage() {
      Future dialog(
        Function() yesOnPressed,
      ) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            actions: [
              CustomButton(
                text: "Yes",
                width: 70,
                onPressed: yesOnPressed,
              ),
              CustomButton(
                text: "No",
                width: 70,
                backGroundColor: kRedColor,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }

      Widget formCard() {
        return Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              color: kWhiteColor,
            ),
            child: Form(
              key: formKey,
              child: FutureBuilder(
                future: fetchUserInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text("No Data");
                  } else {
                    return ListView(
                      children: [
                        CustomTextField(
                          titleText: "Username",
                          controller: nameController,
                          hintText: snapshot.data!.name,
                          obscureText: false,
                          inputType: TextInputType.name,
                        ),
                        CustomTextField(
                            titleText: "Email Address",
                            controller: emailController,
                            hintText: snapshot.data!.email,
                            obscureText: false,
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              } else if (!value.contains("@")) {
                                return "Please enter with email format";
                              }
                              return null;
                            }),
                        CustomTextField(
                          titleText: "Password",
                          controller: passwordController,
                          obscureText: obscure,
                          inputType: TextInputType.text,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _visiblePassword();
                            },
                            child: Icon(obscure
                                ? Icons.lock_outline
                                : Icons.lock_open_outlined),
                          ),
                        ),
                        CustomTextField(
                          titleText: "Hobby",
                          controller: hobbyController,
                          hintText: snapshot.data!.hobby,
                          obscureText: false,
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomButton(
                              text: "Delete",
                              width: 122,
                              onPressed: () async {
                                dialog(
                                  () async {
                                    final deleteUserInfo =
                                        await userServices.deleteUser();
                                    if (deleteUserInfo) {
                                      if (context.mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          "/",
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                      return Fluttertoast.showToast(
                                        msg: "Success Delete Account",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: kWhiteColor,
                                        textColor: kBlackColor,
                                        fontSize: 16.0,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            CustomButton(
                              text: "Save",
                              width: 122,
                              onPressed: () {
                                dialog(
                                  () async {
                                    if (formKey.currentState!.validate()) {
                                      bool updateUser =
                                          await userServices.updateUser(
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        hobbyController.text,
                                      );
                                      if (updateUser) {
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                        userServices.showUser();
                                        return Fluttertoast.showToast(
                                          msg: "Success Update Account",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: kWhiteColor,
                                          textColor: kBlackColor,
                                          fontSize: 16.0,
                                        );
                                      } else {
                                        return Fluttertoast.showToast(
                                          msg: "Failed Update Account",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: kWhiteColor,
                                          textColor: kBlackColor,
                                          fontSize: 16.0,
                                        );
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        CustomButton(
                          margin: const EdgeInsets.only(top: 20),
                          text: "Top Up",
                          width: 248,
                          onPressed: () {
                            return showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Form(
                                  key: formBalanceKey,
                                  child: CustomTextField(
                                    titleText: "Balance",
                                    controller: balanceController,
                                    inputType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Field can not empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                title: const Text("Add money"),
                                actions: [
                                  CustomButton(
                                    text: "Save",
                                    width: 70,
                                    onPressed: () {
                                      if (formBalanceKey.currentState!
                                          .validate()) {}
                                    },
                                  ),
                                  CustomButton(
                                    text: "Close",
                                    width: 70,
                                    backGroundColor: kRedColor,
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                            // return Fluttertoast.showToast(
                            //   msg: "Success Log Out Account",
                            //   toastLength: Toast.LENGTH_SHORT,
                            //   gravity: ToastGravity.BOTTOM,
                            //   backgroundColor: kWhiteColor,
                            //   textColor: kBlackColor,
                            //   fontSize: 16.0,
                            // );
                          },
                        ),
                        CustomButton(
                          margin: const EdgeInsets.only(top: 20),
                          text: "Log Out",
                          width: 248,
                          onPressed: () {
                            dialog(
                              () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/",
                                  (Route<dynamic> route) => false,
                                );
                                sharedServices.deleteCacheUser();
                                return Fluttertoast.showToast(
                                  msg: "Success Log Out Account",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: kWhiteColor,
                                  textColor: kBlackColor,
                                  fontSize: 16.0,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        );
      }

      return SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 20),
              formCard(),
            ],
          ),
        ),
      );
    }

    Widget bottomNavigationBar() {
      return Container(
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(defaultRadius),
          child: NavigationBar(
            onDestinationSelected: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: currentPageIndex,
            backgroundColor: kWhiteColor,
            animationDuration: const Duration(milliseconds: 700),
            destinations: [
              NavigationDestination(
                selectedIcon: Image.asset(
                  "assets/icon_home.png",
                  width: 24,
                  height: 24,
                ),
                icon: Image.asset(
                  "assets/icon_home.png",
                  width: 24,
                  height: 24,
                  color: kGreyColor,
                ),
                label: "Home",
              ),
              NavigationDestination(
                selectedIcon: Image.asset(
                  "assets/icon_card.png",
                  width: 24,
                  height: 24,
                  color: kPrimaryColor,
                ),
                icon: Image.asset(
                  "assets/icon_card.png",
                  width: 24,
                  height: 24,
                ),
                label: "Wallet",
              ),
              const NavigationDestination(
                selectedIcon: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                  color: kPrimaryColor,
                ),
                icon: Icon(
                  Icons.person_2_outlined,
                  size: 24,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: [
        homePage(),
        walletPage(),
        profilePage(),
      ][currentPageIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}

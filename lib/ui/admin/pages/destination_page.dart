import 'package:flutter/material.dart';

import '../../../services/destination_services.dart';
import '../../../shared/theme.dart';
import '../../../widget/custom_destination_tile.dart';
import '../../user/pages/destination_detail_page.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationServices destinationServices = DestinationServices();
    final fetchDestination =
        destinationServices.getListDestination("allDestination");

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
                      destinationId: snapshot.data![index].id,
                      admin: true,
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          listDestination(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: kWhiteColor,
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/AddDestinationPage");
        },
      ),
    );
  }
}

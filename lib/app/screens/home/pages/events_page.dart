import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/screens/home/components/events_trending_card.dart';
import 'package:bus_admin_app/app/screens/home/pages/bus_info_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_create_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_edit_page.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/app/widgets/modals/events_create_modal.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 50, right: 50, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'List of events',
                style: TextStyle(fontSize: 28),
              ),
              Theme(
                data: ThemeData(dialogBackgroundColor: Colors.white),
                child: Builder(builder: (context) {
                  return SizedBox(
                      width: 120,
                      child: CustomButton(
                        text: 'Add event',
                        function: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EventCreateModal();
                            },
                          );
                        },
                      ));
                }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('events').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                      width: 50,
                      child:
                          CircularProgressIndicator()); // Display a loading indicator while waiting for data
                }
                if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Display an error message if there's an error
                }
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  // Iterate through the documents in the snapshot and build your UI
                  return ListView(
                    padding: EdgeInsets.only(top: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: EventsTrendingCard(data: data),
                      );
                    }).toList(),
                  );
                } else {
                  return Text(
                      'No data'); // Handle case where there are no documents in the collection
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/screens/home/pages/bus_info_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_create_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_edit_page.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
                'List of messages',
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('callbacks').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              // Initialize a list to hold DataRow widgets
              List<DataRow> rows = [];

              // Loop through each document in the snapshot
              snapshot.data!.docs.forEach((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                DataRow row = DataRow(cells: [
                  DataCell(Text(data['name'])),
                  DataCell(Text(data['email'])),
                  DataCell(Text(data['message'])),
                ]);

                // Add the DataRow to the list of rows
                rows.add(row);
              });

              // Return the DataTable with the populated rows
              return DataTable(
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Message')),
                  ],
                  rows: rows);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/screens/home/pages/bus_info_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_create_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/home_edit_page.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

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
                'List of clients',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                  width: 120,
                  child: CustomButton(
                    text: 'Add client',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeCreateCompanyPage()),
                      );
                    },
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('companies').snapshots(),
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

                // Create a DataRow for each document
                DataRow row = DataRow(
                    onSelectChanged: (val) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusInfoPage(
                                  companyData: data,
                                )),
                      );
                    },
                    cells: [
                      DataCell(Text(data['bin'])),
                      DataCell(Text(data['name'])),
                      DataCell(Text(data['director'])),
                      DataCell(Text(data['mail'])),
                      DataCell(Text(data['address'])),
                      DataCell(Text(data['phone'])),
                      DataCell(Text(data['kbe'].toString())),
                      DataCell(Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeEditCompanyPage(
                                            data: data,
                                          )),
                                );
                              },
                              child: Icon(Icons.edit_note_rounded)),
                          SizedBox(width: 15),
                          InkWell(
                              onTap: () async {
                                for (var i = 0;
                                    i < data['routes'].length;
                                    i++) {
                                  try {
                                    await ApiClient()
                                        .delete('routes', data['routes'][i]);
                                  } catch (e) {}
                                }
                                await ApiClient()
                                    .delete('companies', data['companyID']);
                                CustomSnackBar.show(
                                    context, 'Deleted successfully!', true);
                              },
                              child: Icon(Icons.delete, color: Colors.red)),
                        ],
                      )),
                    ]);

                // Add the DataRow to the list of rows
                rows.add(row);
              });

              // Return the DataTable with the populated rows
              return DataTable(
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(label: Text('BIN')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Director')),
                    DataColumn(label: Text('Mail')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Phone number')),
                    DataColumn(label: Text('KBE')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: rows);
            },
          ),
        ],
      ),
    );
  }
}

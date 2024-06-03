import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'List of users',
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('admins').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              var users = snapshot.data!.docs;

              return (users.length != 0)
                  ? SizedBox(
                      height: 150, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection:
                            Axis.horizontal, // Set the scroll direction
                        shrinkWrap: true,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          var userData =
                              users[index].data() as Map<String, dynamic>;
                          var userPhone = userData['phone'];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5), // Adjust spacing between items
                            padding: EdgeInsets.all(10),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 80,
                                ),
                                SizedBox(width: 40),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userPhone),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('Not found!'),
                    );
            },
          ),
        ],
      ),
    );
  }
}

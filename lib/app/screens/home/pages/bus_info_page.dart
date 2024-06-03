import 'package:bus_admin_app/app/screens/home/components/bus_route_card.dart';
import 'package:bus_admin_app/app/screens/home/pages/bus_stop_card.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class BusInfoPage extends StatefulWidget {
  final Map<String, dynamic>
      companyData; // Assuming companyData is a map containing route information
  const BusInfoPage({Key? key, required this.companyData}) : super(key: key);

  @override
  State<BusInfoPage> createState() => _BusInfoPageState();
}

class _BusInfoPageState extends State<BusInfoPage> {
  List<DocumentSnapshot> routesData = [];
  var isVisible = [];
  @override
  void initState() {
    super.initState();
    fetchRoutes(widget.companyData['routes']);
  }

  fetchRoutes(List<dynamic> routeIds) async {
    // Construct query to fetch routes based on the provided list of route IDs
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('routes')
        .where(FieldPath.documentId, whereIn: routeIds)
        .get();

    // Store documents in routesData list
    setState(() {
      routesData = querySnapshot.docs;
      for (var i = 0; i < routesData.length; i++) {
        isVisible.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Color.fromARGB(255, 220, 219, 219))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 15),
                          child: Text(
                            'Routes',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: routesData.length,
                          itemBuilder: (context, index) {
                            var route = routesData[index].data()
                                as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      route['aPoint'] + ' - ' + route['bPoint'],
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 18),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (isVisible[index]) {
                                          isVisible[index] = false;
                                        } else {
                                          isVisible[index] = true;
                                        }
                                      });
                                    },
                                  ),
                                  (isVisible[index] == true)
                                      ? Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, right: 15),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 1,
                                                        spreadRadius: 1,
                                                        color: Color.fromARGB(
                                                            255, 239, 239, 239))
                                                  ]),
                                              padding: EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Company : ' +
                                                            widget.companyData[
                                                                'name'],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      Icon(Icons.close)
                                                    ],
                                                  ),
                                                  Text(
                                                    'BIN : ' +
                                                        widget
                                                            .companyData['bin'],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            AppColors.primary,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Active',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primary),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            BusRouteCard(
                                                isLast: false,
                                                title: 'Distance',
                                                subTitle: routesData[index]
                                                    ['distance']),
                                            BusRouteCard(
                                                isLast: false,
                                                title: 'Estimate time',
                                                subTitle: routesData[index]
                                                    ['estimate']),
                                            BusRouteCard(
                                                isLast: true,
                                                title: 'Number of stops',
                                                subTitle: routesData[index]
                                                        ['stops']
                                                    .length
                                                    .toString()),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: BookStopCard(
                                                  routesData:
                                                      routesData[index]),
                                            ),
                                          ],
                                        )
                                      : SizedBox()
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.9,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        infoCard('Name', widget.companyData['name']),
                        SizedBox(
                          width: 40,
                        ),
                        infoCard('BIN', widget.companyData['bin']),
                        SizedBox(
                          width: 40,
                        ),
                        infoCard('Address', widget.companyData['address']),
                        SizedBox(
                          width: 40,
                        ),
                        infoCard('KBE Number', widget.companyData['kbe']),
                        SizedBox(
                          width: 40,
                        ),
                        Container()
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/0/0d/Tartu_rail_station_OSM_map.png?20140307134938'),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: Color.fromARGB(255, 239, 239, 239),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: Color.fromARGB(255, 239, 239, 239),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(24), // Image radius
                                      child: Image.network(
                                          widget.companyData['driver']['image'],
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(widget.companyData['driver']['name'])
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Phone: ' +
                                  widget.companyData['driver']['phone']),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Email: ' +
                                  widget.companyData['driver']['mail']),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  color: Color.fromARGB(255, 239, 239, 239),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text('Documents'),
                                Divider(),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    CustomSnackBar.show(
                                        context,
                                        'User document url:  https://pdfobject.com/pdf/sample.pdf',
                                        true);
                                  },
                                  child: Icon(
                                    Icons.document_scanner,
                                    size: 45,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('USER DOCUMENT')
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  infoCard(title, subTitle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Color.fromARGB(255, 239, 239, 239),
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            subTitle,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400]),
          )
        ],
      ),
    );
  }
}

import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/functions/global_function.dart';
import 'package:bus_admin_app/app/screens/home/components/home_date_container.dart';
import 'package:bus_admin_app/app/screens/home/components/home_search_card.dart';
import 'package:bus_admin_app/app/screens/home/components/home_search_container.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/app/widgets/modals/search_modal.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:intl/intl.dart';

class HomeCreateCompanyPage extends StatefulWidget {
  const HomeCreateCompanyPage({super.key});

  @override
  State<HomeCreateCompanyPage> createState() => _HomeCreateCompanyPageState();
}

class _HomeCreateCompanyPageState extends State<HomeCreateCompanyPage> {
  String selectedDay = '';
  String startTime = '';
  String finishTime = '';
  String stopStart = '';
  String stopFinish = '';
  String fromValue = '';
  String toValue = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  var stopsData = [];
  var addedImages = [];
  var routes = [];
  TextEditingController name = TextEditingController();
  TextEditingController bin = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController director = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController kbe = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverSurname = TextEditingController();
  TextEditingController driverPhone = TextEditingController();
  TextEditingController stopName = TextEditingController();

  TextEditingController startStation = TextEditingController();
  TextEditingController finishStation = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController finishTimeController = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController estimate = TextEditingController();

  TextEditingController price1 = TextEditingController();
  TextEditingController price2 = TextEditingController();
  TextEditingController price3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryWhite,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 200, right: 200, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Create company',
                        style:
                            TextStyle(fontSize: 22, color: AppColors.primary),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'General informations',
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                String image = await GlobalFunctions()
                                    .uploadImageToImgBB(context);
                                if (image != 'null') {
                                  if (addedImages.length == 0) {
                                    addedImages.add(image);
                                    setState(() {});
                                  } else {
                                    addedImages[0] = image;
                                    setState(() {});
                                  }
                                } else {
                                  CustomSnackBar.show(
                                      context, 'Error picking image', false);
                                }
                              },
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  width:
                                      MediaQuery.of(context).size.width / 3.2,
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  decoration: BoxDecoration(
                                      image: (addedImages.length != 0)
                                          ? DecorationImage(
                                              image:
                                                  NetworkImage(addedImages[0]))
                                          : null,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: AppColors.primary)),
                                  child: (addedImages.length == 0)
                                      ? Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.black,
                                            size: 100,
                                          ),
                                        )
                                      : null),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                (addedImages.length > 1)
                                    ? Row(
                                        children: addedImages.map((e) {
                                          int index = addedImages.indexOf(e);
                                          if (index == 0) {
                                            return SizedBox();
                                          } else {
                                            return InkWell(
                                              onDoubleTap: () {
                                                addedImages.removeAt(index);
                                                setState(() {});
                                              },
                                              onTap: () async {
                                                String image =
                                                    await GlobalFunctions()
                                                        .uploadImageToImgBB(
                                                            context);
                                                if (image != 'null') {
                                                  addedImages[index] = image;
                                                  setState(() {});
                                                } else {
                                                  CustomSnackBar.show(
                                                      context,
                                                      'Error picking image',
                                                      false);
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left:
                                                        (index == 1) ? 0 : 20),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(e)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.primary)),
                                                width: 50,
                                                height: 50,
                                              ),
                                            );
                                          }
                                        }).toList(),
                                      )
                                    : SizedBox(),
                                InkWell(
                                  onTap: () async {
                                    String image = await GlobalFunctions()
                                        .uploadImageToImgBB(context);
                                    if (image != 'null') {
                                      addedImages.add(image);
                                      setState(() {});
                                    } else {
                                      CustomSnackBar.show(context,
                                          'Error picking image', false);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left:
                                            (addedImages.length >= 2) ? 20 : 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.primary)),
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Name',
                      controller: name,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'BIN',
                      controller: bin,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Mail',
                      controller: mail,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Director',
                      controller: director,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Phone',
                      controller: phone,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Address',
                      controller: address,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'KBE',
                      controller: kbe,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Routes',
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (routes.length != 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: routes.map((e) {
                              int index = routes.indexOf(e);
                              return Container(
                                alignment: Alignment.topLeft,
                                width: 250,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 5, color: Colors.grey)
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bus_alert,
                                          color: AppColors.primary,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          e['aPoint'] + ' - ' + e['bPoint'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          routes.remove(index);
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              );
                            }).toList())
                        : SizedBox(),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            var data = await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              builder: (context) {
                                return SearchModal();
                              },
                            );
                            fromValue = data;
                            setState(() {});
                          },
                          child: HomeSearchContainer(
                              title: 'From', value: fromValue),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () async {
                            var data = await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              builder: (context) {
                                return SearchModal();
                              },
                            );
                            toValue = data;
                            setState(() {});
                          },
                          child:
                              HomeSearchContainer(title: 'To', value: toValue),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                hintText: 'Start station',
                                controller: startStation)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Finish station',
                              controller: finishStation),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                hintText: 'Distance', controller: distance)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Estimate time', controller: estimate),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Prices: '),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                                hintText: 'Price for Restricted',
                                controller: price1)),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Price for Standard',
                              controller: price2),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CustomTextField(
                              hintText: 'Price for Fully Flexible',
                              controller: price3),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Bus road time '),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                          .map<Widget>((e) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDay = e;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: (selectedDay != e)
                                ? Colors.grey[300]
                                : AppColors.primary,
                            child: Center(
                              child: Text(
                                e.toString(),
                                style: TextStyle(
                                  color: (selectedDay != e)
                                      ? Colors.black
                                      : AppColors.kPrimaryWhite,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        alwaysUse24HourFormat: false,
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedTime != null &&
                                    pickedTime != selectedTime) {
                                  setState(() {
                                    selectedTime = pickedTime;
                                    // Format the selected time using DateFormat with 24-hour format
                                    final formattedTime =
                                        DateFormat.Hm().format(
                                      DateTime(2022, 1, 1, pickedTime.hour,
                                          pickedTime.minute),
                                    );
                                    startTime = formattedTime;
                                  });
                                }
                              },
                              child: HomeSearchDate(
                                  title: 'Start', value: startTime)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                                builder: (context, child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: false,
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedTime != null &&
                                  pickedTime != selectedTime) {
                                setState(() {
                                  selectedTime = pickedTime;
                                  // Format the selected time using DateFormat with 24-hour format
                                  final formattedTime = DateFormat.Hm().format(
                                    DateTime(2022, 1, 1, pickedTime.hour,
                                        pickedTime.minute),
                                  );
                                  finishTime = formattedTime;
                                });
                              }
                            },
                            child: HomeSearchDate(
                                title: 'Finish', value: finishTime),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Stops '),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (stopsData.length == 0)
                        ? SizedBox(
                            height: 15,
                          )
                        : Column(
                            children: stopsData.map((e) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.bus_alert,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    e['name'] + ' - ',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Text(
                                      '(' +
                                          e['stopStart'] +
                                          '-' +
                                          e['stopFinish'] +
                                          ')',
                                      style: TextStyle(fontSize: 24))
                                ],
                              );
                            }).toList(),
                          ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CustomTextField(
                              hintText: 'Stop name', controller: stopName),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime,
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        alwaysUse24HourFormat: false,
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedTime != null &&
                                    pickedTime != selectedTime) {
                                  setState(() {
                                    selectedTime = pickedTime;
                                    // Format the selected time using DateFormat with 24-hour format
                                    final formattedTime =
                                        DateFormat.Hm().format(
                                      DateTime(2022, 1, 1, pickedTime.hour,
                                          pickedTime.minute),
                                    );
                                    stopStart = formattedTime;
                                  });
                                }
                              },
                              child: HomeSearchDate(
                                  title: 'Start', value: stopStart)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                                builder: (context, child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: false,
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedTime != null &&
                                  pickedTime != selectedTime) {
                                setState(() {
                                  selectedTime = pickedTime;
                                  // Format the selected time using DateFormat with 24-hour format
                                  final formattedTime = DateFormat.Hm().format(
                                    DateTime(2022, 1, 1, pickedTime.hour,
                                        pickedTime.minute),
                                  );
                                  stopFinish = formattedTime;
                                });
                              }
                            },
                            child: HomeSearchDate(
                                title: 'Finish', value: stopFinish),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 200,
                            child: CustomButton(
                              text: 'Add stop',
                              function: () {
                                stopsData.add({
                                  'name': stopName.text,
                                  'stopStart': stopStart,
                                  'stopFinish': stopFinish,
                                });
                                stopName.text = '';
                                stopStart = '';
                                stopFinish = '';
                                setState(() {});
                              },
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: 'Add route',
                      function: () {
                        // var seats = GlobalFunctions().generateMatrix(15);
                        var data = {
                          'aPoint': fromValue,
                          'bPoint': toValue,
                          'aPointStation': startStation.text,
                          'bPointStation': finishStation.text,
                          'startTime': startTime,
                          'finishTime': finishTime,
                          'distance': distance.text,
                          'estimate': estimate.text,
                          'prices': [price1.text, price2.text, price3.text],
                          'roadDay': selectedDay,
                          'stops': stopsData,
                          'seats': []
                        };

                        routes.add(data);
                        fromValue = '';
                        toValue = '';
                        finishStation.text = '';
                        startStation.text = '';
                        startTime = '';
                        finishTime = '';
                        distance.text = '';
                        estimate.text = '';
                        price1.text = '';
                        price2.text = '';
                        price3.text = '';
                        selectedDay = '';
                        stopsData = [];
                        setState(() {});
                      },
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Driver',
                          style:
                              TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: 'Driver name', controller: driverName),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        hintText: 'Driver surname', controller: driverSurname),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        hintText: 'Driver phone', controller: driverPhone),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Driver document '),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.add_to_drive,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: 'Create company',
                      function: () async {
                        try {
                          var data = {
                            'name': name.text,
                            'bin': bin.text,
                            'mail': mail.text,
                            'director': director.text,
                            'phone': phone.text,
                            'address': address.text,
                            'kbe': kbe.text,
                            'images': addedImages,
                            'driver': {
                              'name': driverName.text,
                              'surname': driverSurname.text,
                              'phone': driverPhone.text
                            }
                          };
                          String createdCompanyId = await ApiClient()
                              .globalCreate('companies', data, 'companyID');
                          List routeDataIds = [];
                          for (var route in routes) {
                            Map<String, dynamic> routeData = {
                              'aPoint': route['aPoint'],
                              'bPoint': route['bPoint'],
                              'aPointStation': route['aPointStation'],
                              'bPointStation': route['bPointStation'],
                              'startTime': route['startTime'],
                              'finishTime': route['finishTime'],
                              'distance': route['distance'],
                              'estimate': route['estimate'],
                              'prices': route['prices'],
                              'roadDay': route['roadDay'],
                              'stops': route['stops'],
                              'seats': route['seats'],
                              'companyID': createdCompanyId
                            };
                            String createdRouteId = await ApiClient()
                                .globalCreate('routes', routeData, 'routeID');
                            routeDataIds.add(createdRouteId);
                          }
                          data['routes'] = routeDataIds;
                          await ApiClient()
                              .update('companies', createdCompanyId, data);
                          CustomSnackBar.show(context, 'Created!', true);
                          Navigator.pop(context);
                        } catch (e) {
                          CustomSnackBar.show(context, e.toString(), true);
                        }
                      },
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
}

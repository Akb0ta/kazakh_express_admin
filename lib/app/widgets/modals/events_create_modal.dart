import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/functions/global_function.dart';
import 'package:bus_admin_app/app/screens/home/components/home_search_container.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/app/widgets/modals/search_modal.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCreateModal extends StatefulWidget {
  const EventCreateModal({super.key});

  @override
  State<EventCreateModal> createState() => _EventCreateModalState();
}

class _EventCreateModalState extends State<EventCreateModal> {
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController price = TextEditingController();
  String image = '';
  String city = '';
  String selectedDate = '';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd/MM/yyyy').format(picked);
        date.text = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Create Event'),
      content: Container(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    String im =
                        await GlobalFunctions().uploadImageToImgBB(context);
                    if (im != 'null') {
                      setState(() {
                        image = im;
                      });
                    } else {
                      CustomSnackBar.show(
                          context, 'Error picking image', false);
                    }
                  },
                  child: Container(
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width / 3.2,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                          image: (image != '')
                              ? DecorationImage(image: NetworkImage(image))
                              : null,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary)),
                      child: (image == '')
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
                  height: 10,
                ),
                CustomTextField(hintText: 'Name', controller: name),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    await _selectDate(context);
                  },
                  child: CustomTextField(
                    hintText: 'DD/MM/YYYY',
                    isEnabled: false,
                    controller: date,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    hintText: 'Description', controller: description),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    var data = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      builder: (context) {
                        return SearchModal();
                      },
                    );
                    city = data;
                    setState(() {});
                  },
                  child: HomeSearchContainer(title: 'From', value: city),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(hintText: 'Location', controller: location),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(hintText: 'Price', controller: price),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Add',
                  function: () async {
                    await ApiClient().globalCreate(
                        'events',
                        {
                          'name': name.text,
                          'description': description.text,
                          'location': location.text,
                          'price': price.text,
                          'city': city,
                          'image': image,
                          'date': date.text
                        },
                        'id');
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        )),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

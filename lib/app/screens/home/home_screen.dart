import 'package:bus_admin_app/app/screens/home/pages/company_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/events_page.dart';
import 'package:bus_admin_app/app/screens/home/pages/users_page.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedType = 0;
  List pages = [CompanyPage(), UsersPage(), EventsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 15, color: Colors.grey)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = 0;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: (selectedType == 0)
                                      ? AppColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              width:
                                  MediaQuery.of(context).size.width / 2.3 / 2,
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Company',
                                  style: TextStyle(
                                    color: (selectedType == 0)
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = 1;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: (selectedType == 1)
                                      ? AppColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              width:
                                  MediaQuery.of(context).size.width / 2.3 / 2,
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Users',
                                  style: TextStyle(
                                    color: (selectedType == 1)
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedType = 2;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: (selectedType == 2)
                                      ? AppColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              width:
                                  MediaQuery.of(context).size.width / 2.3 / 2,
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Events',
                                  style: TextStyle(
                                    color: (selectedType == 2)
                                        ? Colors.white
                                        : Colors.grey[400],
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width / 5,
                    child: Center(
                        child: Image.asset(
                      'assets/images/login_image.png',
                      width: MediaQuery.of(context).size.width / 5.5,
                    )),
                  )
                ],
              ),
            ),
            pages[selectedType]
          ],
        ),
      ),
    );
  }
}

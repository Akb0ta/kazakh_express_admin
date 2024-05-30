import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class BusRouteCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isLast;
  const BusRouteCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: (isLast == true) ? 0.0 : 50),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 5,
                      ),
                    ),
                  ),
                ),
                (isLast == true)
                    ? SizedBox()
                    : SizedBox(
                        height: 20,
                      ),
                (isLast == true)
                    ? SizedBox()
                    : Container(
                        width: 1, // Width of the line
                        height: 40, // Height of the line
                        color: Colors.black, // Color of the line
                      ),
              ],
            ),

            // Adjust the space between the line and the next container
            Container(
              width: MediaQuery.of(context).size.width / 5.3,
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
              margin: EdgeInsets.only(left: 15, right: 15),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

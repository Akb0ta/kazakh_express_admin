import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeSearchCard extends StatelessWidget {
  const HomeSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.primary,
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/bus.png',
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Almatyelectronics')
                ],
              ),
              Container(
                color: Colors.green.withOpacity(0.2),
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  'CHEAP',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w700),
                )),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '10:15 AM',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Text(
                '20:45 AM',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Almaty',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Column(
                children: [
                  Text(
                    '10h 30 ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '⦿ - - - - - ',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.bus_alert,
                        color: Colors.black,
                      ),
                      Text(
                        ' - - - - - ⦿',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'Shymkent',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
          Divider(
            color: AppColors.primary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '8000 KZT - 11000 KZT',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.primary),
                child: Center(
                  child: Text(
                    'View more',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

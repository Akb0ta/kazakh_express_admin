import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController login = TextEditingController();
    TextEditingController pass = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(50),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset('assets/images/login_image.png'),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(hintText: 'Login', controller: login),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(hintText: 'Password', controller: pass),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(text: 'Login'),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Image.asset(
                      'assets/images/login_big_image.png',
                      width: 450,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

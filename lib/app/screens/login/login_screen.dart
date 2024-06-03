import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/screens/home/home_screen.dart';
import 'package:bus_admin_app/app/screens/register/register_screen.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_phone_textfield.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
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
                        height: 30,
                      ),
                      Image.asset('assets/images/login_image.png'),
                      SizedBox(
                        height: 30,
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
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/kz-flag.png',
                                  width: 24,
                                ),
                                Text(
                                  '+7',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 3),
                          Flexible(
                            child: TextFieldInput(
                              hintText: 'Номер телефона',
                              textInputType: TextInputType.phone,
                              textEditingController: phone,
                              isPhoneInput: true,
                              autoFocus: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Enter your password'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: '*********',
                        controller: pass,
                        isPassword: true,
                        passwordShow: isShowPassword,
                        onTapIcon: () {
                          setState(() {
                            if (isShowPassword) {
                              isShowPassword = false;
                            } else {
                              isShowPassword = true;
                            }
                            setState(() {});
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: 'Login',
                        function: () async {
                          String adminId =
                              await ApiClient().login(phone.text, pass.text);
                          if (adminId != '') {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('id', adminId);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false);
                          } else {
                            CustomSnackBar.show(
                                context, 'Incorrect login or password!', false);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Dont have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 15),
                            ),
                          )
                        ],
                      ),
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

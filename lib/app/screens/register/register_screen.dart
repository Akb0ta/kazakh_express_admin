import 'package:bus_admin_app/api/api_client.dart';
import 'package:bus_admin_app/app/screens/home/home_screen.dart';
import 'package:bus_admin_app/app/screens/login/login_screen.dart';
import 'package:bus_admin_app/app/screens/verify/function.dart';
import 'package:bus_admin_app/app/screens/verify/verify_screen.dart';
import 'package:bus_admin_app/app/widgets/buttons/custom_button.dart';
import 'package:bus_admin_app/app/widgets/custom_snackbar.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_phone_textfield.dart';
import 'package:bus_admin_app/app/widgets/textfields/custom_textfiled.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rPass = TextEditingController();
  bool isShowPassword = true;
  bool isShowRPassword = true;
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
                        'Get started',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'by creating an account',
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
                        height: 10,
                      ),
                      Text('Confirm your password'),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        hintText: '*********',
                        controller: rPass,
                        isPassword: true,
                        passwordShow: isShowRPassword,
                        onTapIcon: () {
                          setState(() {
                            if (isShowRPassword) {
                              isShowRPassword = false;
                            } else {
                              isShowRPassword = true;
                            }
                            setState(() {});
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        text: 'Sign Up',
                        function: () async {
                          String adminId = await ApiClient()
                              .fieldExists('admins', 'phone', phone.text);
                          String phoneNumber = phone.text
                              .replaceAll("-", "")
                              .replaceAll("(", "")
                              .replaceAll(")", "");
                          if (adminId != '') {
                            CustomSnackBar.show(context,
                                'User with this phone number exists!', false);
                          } else {
                            if (phone.text.length != 0 &&
                                pass.text == rPass.text) {
                              String pin = SignFunctions()
                                  .generateRandomPin()
                                  .toString();
                              bool isSuccess = await SignFunctions()
                                  .sendVerificationCode(
                                      phoneNumber: '7' + phoneNumber,
                                      generatedCode: pin);
                              if (isSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyCodePage(
                                            email: phone.text,
                                            pass: pass.text,
                                            pin: pin,
                                          )),
                                );
                              } else {
                                CustomSnackBar.show(context,
                                    'Phone number format error!', false);
                              }
                            } else {
                              CustomSnackBar.show(
                                  context, 'Please fill all fields!', false);
                            }
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              'Log in',
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

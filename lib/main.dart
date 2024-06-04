import 'package:bus_admin_app/app.dart';
import 'package:bus_admin_app/app/screens/login/login_screen.dart';
import 'package:bus_admin_app/data/local_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyC90-AQR_V6T_bNvPaRrVFpAtjzYJAXTm0',
    appId: '1:789310177341:web:8781f595eb142083a3aa54',
    messagingSenderId: '789310177341',
    projectId: 'bus-app-iitu',
    authDomain: 'bus-app-iitu.firebaseapp.com',
    storageBucket: 'bus-app-iitu.appspot.com',
  ));

  await LocalData.instance.initDatas();
  String userId = prefs.getString('id') ?? '';
  bool isLogged = false;
  if (userId != '') {
    isLogged = true;
  }
  runApp(BusApp(isLogged: isLogged));
}

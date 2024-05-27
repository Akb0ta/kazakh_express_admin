import 'package:bus_admin_app/app/screens/bloc/just_bloc.dart';
import 'package:bus_admin_app/app/screens/home/home_screen.dart';
import 'package:bus_admin_app/app/screens/login/login_screen.dart';
import 'package:bus_admin_app/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusApp extends StatelessWidget {
  final bool isLogged;
  const BusApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => JustBloc()..add(JustLoad()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bus App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
          primaryColor: AppColors.primaryColor,
          dividerColor: AppColors.primaryColor,
        ),
        home: MediaQuery(
          child: (isLogged) ? HomeScreen() : HomeScreen(),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        ),
      ),
    );
  }
}

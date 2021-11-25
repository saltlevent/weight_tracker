import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weight_tracker/Pages/auth_pages/login_page.dart';
import 'package:weight_tracker/Pages/nav_pages/home_page.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/models/user_model.dart';

import 'Pages/main_page.dart';
import 'providers/current_user_provider.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    if(){

    } else{
      return ;
    }
    */
    return GetMaterialApp(
      title: 'Weight Tracker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: const AppBarTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          shadowColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 20),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            splashColor: Colors.orange,
            backgroundColor: Color(0xff6470b3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
        ),
      ),
      home: checkUser()
        ?const MainPage()
        :const LoginPage()
      );
  }

  bool checkUser(){
  var user = FirebaseAuth.instance;

  if(user.currentUser != null){
    return true;
  } else{
    return false;
  }
}
}


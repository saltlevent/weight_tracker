import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/Pages/auth_pages/login_page.dart';
import 'package:weight_tracker/controller_getx.dart';
import 'package:weight_tracker/models/user_model.dart';
import 'package:weight_tracker/services/firebase_auth.dart';
import 'package:weight_tracker/services/firebase_database.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerGetx _controller = Get.find();

    final AuthFirebase _auth = AuthFirebase();
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future: FirebaseDatabase().getUserData(),
          initialData: UserModel(email: "", userName: ""),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "User Name: ",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        snapshot.data!.userName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "E-mail: ",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        snapshot.data!.email,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                  TextButton(
                    child: const Text(
                      "Log Off",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {
                      _controller.records.clear();
                      Get.to(() => const LoginPage(), popGesture: true);
                      _auth.signOut();
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

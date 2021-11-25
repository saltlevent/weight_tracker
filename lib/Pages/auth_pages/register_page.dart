import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/services/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  //when the firebase process running it shows the CircularIndicator
  bool isProcessing = false;

  final AuthFirebase _auth = AuthFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: isProcessing
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(20)),
                child: ListView(children: [

                  buildUsernameField(),
                  buildEmailField(),
                  buildPasswordField(),
                  buildRePasswordField(),

                  //register button
                  TextButton(
                    child: const Text("Register", style: TextStyle(fontSize: 22)),
                    onPressed: () => onPressRegister(),
                  ),

                  //cancel button
                  TextButton(
                    child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ]),
              ));
  }

  Container buildRePasswordField() {
    return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                  child: TextField(
                    controller: _repasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "password Here.", labelText: "re enter password", border: InputBorder.none),
                    onSubmitted: (value) => null,
                  ),
                );
  }

  Container buildPasswordField() {
    return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "password Here.", labelText: "password", border: InputBorder.none),
                    onSubmitted: (value) => null,
                  ),
                );
  }

  Container buildEmailField() {
    return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: const InputDecoration(hintText: "e-mail Adress Here.", labelText: "e-mail", border: InputBorder.none),
                    onSubmitted: (value) => null,
                  ),
                );
  }

  Container buildUsernameField() {
    return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(hintText: "username here", labelText: "username", border: InputBorder.none),
                    onSubmitted: (value) => null,
                  ),
                );
  }

  onPressRegister() {
    //textfield check 1
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _repasswordController.text.isNotEmpty) {
      //email check 1-1
      if (GetUtils.isEmail(_emailController.text)) {
        //password check 1-1-0 (if there is no problem)
        if (_repasswordController.text == _passwordController.text) {
          setState(() {
            isProcessing = true;
          });
          _auth.createUser(_usernameController.text, _emailController.text, _passwordController.text).whenComplete(() {
            setState(() {
              isProcessing = false;
            });

            Get.back();
            Get.snackbar("info", "You have signed up");
          });
        } else {
          Get.snackbar("error", "please check the passwords", duration: const Duration(seconds: 1));
        }
      } else {
        Get.snackbar("error", "it is not a correct email", duration: const Duration(seconds: 1));
      }
    } else {
      Get.snackbar("error", "please fill the fields", duration: const Duration(seconds: 1));
    }
  }
}

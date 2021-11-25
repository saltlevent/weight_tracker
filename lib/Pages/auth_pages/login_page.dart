import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/Pages/auth_pages/register_page.dart';
import 'package:weight_tracker/services/firebase_auth.dart';

import '../main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthFirebase _auth = AuthFirebase();


  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: isProcessing
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(50),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(20)),
                child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                  buildEmailInput(_emailController),
                  buildPasswordInput(_passwordController),
                  buildLoginButton(),
                  buildToRegisterPageButton()
                ]),
              ));
  }

  Container buildEmailInput(TextEditingController _emailController) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
      child: TextField(
        controller: _emailController,
        decoration: const InputDecoration(hintText: "e-mail Adress Here.", labelText: "e-mail", border: InputBorder.none),
        onSubmitted: (value) => null,
      ),
    );
  }

  Container buildPasswordInput(TextEditingController _passwordController) {
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

  TextButton buildLoginButton() {
    return TextButton(child: const Text("Login", style: TextStyle(fontSize: 22)), onPressed: () => onPressLogin());
  }

  TextButton buildToRegisterPageButton() {
    return TextButton(
      child: const Text("Register", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Get.to(
          () => const RegisterPage(),
          transition: Transition.rightToLeftWithFade,
        );
      },
    );
  }

  onPressLogin() {

    setState(() => isProcessing = true);

    if(GetUtils.isEmail(_emailController.text)){
      _auth.signIn(_emailController.text, _passwordController.text).then((value) {

        Get.to(()=>const MainPage(), popGesture: true);

      }).onError((error, stackTrace) {
        setState(() => isProcessing = false);
      });
    }
    else{
      Get.snackbar("error", "it is not a correct email");
      setState(() => isProcessing = false);
    }
  }
}

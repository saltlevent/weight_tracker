import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/providers/current_user_provider.dart';

class AuthFirebase {
  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //for user data
  final _firestore = FirebaseFirestore.instance.collection("users");

  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);

    try{
      return user.user!;
    } catch(e) {
      return Future.error("Login error $e");
    }
  }

  signOut() async {
    try{
      return await _auth.signOut();
    } catch(e) {
      return Future.error("signOut error $e");
    }
  }

  Future<User?> createUser(String userName, String email, String password) async{

    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await user.user!.updateDisplayName(userName);

    try{
      await _firestore
          .doc(user.user!.uid)
          .set({
        'userName' : userName,
        'email' : email,
        'data' : "",
      });
      return user.user;
    }catch(e){
      return Future.error("create user error $e");
    }

  }
}
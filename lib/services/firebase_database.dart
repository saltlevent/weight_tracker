import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/models/user_model.dart';

class FirebaseDatabase{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future addToDatabase(List<Record> data) async{
    var user = _auth.currentUser;
    try{
      await _firestore
          .collection("users")
          .doc(user!.uid)
          .set({
        'data' : jsonEncode(data),
      },SetOptions(merge: true));
    }catch(e){
      return Future.error(" $e");
    }
  }

  Future<String> getRecordsFromDatabase() async{
    var user = _auth.currentUser;
    var temp = "";
    try{
      await _firestore
          .collection("users")
          .doc(user!.uid).get().then((value){
            temp = value["data"];
      });
      return temp;
    }catch(e){
      return Future.error(" $e");
    }
  }

  Future<UserModel> getUserData() async{
    var user = _auth.currentUser;
    UserModel temp = UserModel(email: "", userName: "");
    try{
      await _firestore
          .collection("users")
          .doc(user!.uid).get().then((value){
           temp = UserModel.fromJson(value.data()!);
      });
      return temp;
    }catch(e){
      return Future.error(" $e");
    }
  }
}
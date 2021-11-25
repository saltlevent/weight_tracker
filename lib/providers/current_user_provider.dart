import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:weight_tracker/models/user_model.dart';

class CurrentUserProvider extends GetxController{

  var userModel = UserModel(email: "", userName: "").obs;
  var data = ''.obs;

  addCurrentUser(String userName, String email){
    userModel = UserModel(email: email, userName: userName).obs;
  }
}
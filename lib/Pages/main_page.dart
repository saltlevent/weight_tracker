import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/Pages/add_record_page.dart';
import 'package:weight_tracker/Pages/nav_pages/home_page.dart';
import 'package:weight_tracker/Pages/nav_pages/user_page.dart';
import 'package:weight_tracker/controller_getx.dart';
import 'package:weight_tracker/providers/current_user_provider.dart';

import 'nav_pages/history_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var navBarIndex = 0;
  var pageTitle = "HOME";
  @override
  Widget build(BuildContext context) {

    final ControllerGetx _controller = Get.put(ControllerGetx());

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navBarIndex,
        items: navigationBarItems(),
        onTap: (index) => navBarOnTap(index)
    ),
      floatingActionButton: buildFloatingActionButton(_controller),
      body: pageSelector(navBarIndex),
    );
  }

  FloatingActionButton buildFloatingActionButton(ControllerGetx _controller){
    return FloatingActionButton(
        onPressed:() => Get.to(AddRecordPage(), transition: Transition.downToUp, opaque: true),
        child: const Icon(Icons.add));
  }

  List<BottomNavigationBarItem> navigationBarItems(){
    return  const [
        BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Home"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User"
        )
      ];
  }
  void navBarOnTap(int index){
    setState(() {
      navBarIndex = index;

      if(index == 0){
        pageTitle = "HOME";
      } else if(index == 1){
        pageTitle = "HISTORY";
      } else if(index == 2){
        pageTitle = "USER";
      } else{
        pageTitle = "ERRoR";
      }
    });
  }

  Widget pageSelector(int PageNumber) {
    if(PageNumber == 0){
      return const HomePage();
    } else if(PageNumber == 1){
      return const HistoryPage();
    } else if(PageNumber == 2){
      return const UserPage();
    } else{
      return Container();
    }

  }

}
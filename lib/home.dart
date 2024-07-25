import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/tabs/home_tab.dart';
import 'package:todo/tabs/settings_tab.dart';
import 'package:todo/bottom_sheet/bottom_sheet.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String RouteName = "Home";

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.AppColor,
        toolbarHeight: 70,
        title: Center(
          child: Text(
            "To Do List",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
          ),
        ),
      ),
      body: Tabs[selectedIndex]
     ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       showModalBottomSheet(isScrollControlled: true,

           context: context, builder: (context) => Padding(
             padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
             ,child: ShowBottomSheet(),
           ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.AppColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(width: 3, color: Colors.white)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin:8 ,
        shape: CircularNotchedRectangle(),
        padding:EdgeInsets.zero,

        child: BottomNavigationBar(
elevation: 0,
            selectedItemColor: AppColors.AppColor,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            backgroundColor: Colors.transparent,
            showUnselectedLabels: false,
            unselectedItemColor: Color(0xffC8C9CB),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_sharp), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ]),
      ),
    );
  }
  List<Widget> Tabs =[ HomeTab(),SettingsTab()
  ];

}
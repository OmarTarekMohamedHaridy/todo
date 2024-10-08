import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/firebase_fun/firebase_function.dart';

import '../item_count.dart';
import '../providers/my_provider.dart';

class HomeTab extends StatefulWidget {
   HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: date,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (dateTime){
              date = dateTime ;
              setState(() {

              });
            },
            leftMargin: 20,
            monthColor: provider.Mytheme == ThemeMode.light
      ? Color(0xff5D9CEC)
            : Color(0xffFFFFFF),
            dayColor: provider.Mytheme == ThemeMode.light
      ? Color(0xff5D9CEC)
            : Color(0xffFFFFFF),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: AppColors.AppColor,
            dotColor: Colors.white,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
          SizedBox(
            height: 30,
          ),

          StreamBuilder(
            stream: FirebaseFunctions.getTasks(date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return  Center(
                  child: Column(
                    children: [
                      Text("Sorry there is error"),
                      ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                    ],
                  ),
                );
              }
var Tasks = snapshot.data?.docs.map((doc) =>doc.data()).toList() ?? [];
              if(Tasks.isEmpty){
                return  Center(child:
                      Text("No Tasks",style: TextStyle(color:provider.Mytheme == ThemeMode.light
                          ? Color(0xff5D9CEC)
                          : Color(0xffFFFFFF),),)

                );
              }
              return
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 20,),
                  itemBuilder: (context, index) {
                  return ItemCount(taskModel: Tasks[index],);
                },
                itemCount:Tasks.length,),
              );
            },
          )
        ],
      ),
    );
  }
}

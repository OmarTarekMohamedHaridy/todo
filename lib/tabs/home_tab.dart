import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/colors.dart';

import '../item_count.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: Column(children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: AppColors.words,
          dayColor: AppColors.AppColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: AppColors.AppColor,
          dotColor: Colors.white,
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        SizedBox(height: 12,),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20,),
            itemBuilder: (context, index) {
            return ItemCount();
          },
          itemCount: 30,),
        ),

      ],),
    );
  }
}

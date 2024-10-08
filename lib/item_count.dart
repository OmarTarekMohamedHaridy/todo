
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/edit_tab.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';


class ItemCount extends StatelessWidget {
  TaskModel taskModel ;
   ItemCount({super.key,required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return
      Container(

          width: double.infinity,
          height: 115,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(

              color: provider.Mytheme ==ThemeMode.light?
              Colors.white10:
              Color(0xff141922), borderRadius: BorderRadius.circular(20)),
          child: Slidable(
            startActionPane: ActionPane(motion:const DrawerMotion(),
            extentRatio: 0.7,
            children:  [
              SlidableAction(autoClose: true,
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topLeft: Radius.circular(20)),
                flex: 2,
                padding: EdgeInsets.zero,
                onPressed: (BuildContext context) { FirebaseFunctions.DeleteTask(taskModel.id); },
              ),
              SlidableAction(autoClose: true,
                onPressed: (BuildContext context) {Navigator.pushNamed(context, EditTab.routeName,
                arguments: taskModel); },
                backgroundColor: AppColors.AppColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  height: 62,
                  width: 4,
                  decoration: BoxDecoration(
                      color:taskModel.isDone?Colors.green : AppColors.AppColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        taskModel.title,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,
                            color:taskModel.isDone?Colors.green : AppColors.AppColor),
                      ),
                      Text(
                     taskModel.subTitle,
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12,
                            color:taskModel.isDone?Colors.green : AppColors.AppColor),
                      ),
                    ],
                  ),
                ),
               taskModel.isDone?Text("Done!",style: TextStyle(fontSize:22,color: Colors.green ),): ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:taskModel.isDone?Colors.green : AppColors.AppColor,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    onPressed: () {
Timer(Duration(seconds: 5), () {
  FirebaseFunctions.DeleteTask(taskModel.id);
}, );
                      taskModel.isDone = true ;
                      FirebaseFunctions.Update(taskModel);},
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ))
              ]),
            ),
          ));

  }
}

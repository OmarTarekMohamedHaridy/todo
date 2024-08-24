import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/colors.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/models/task_model.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.AppColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: subTitleController,
            decoration: InputDecoration(
                label: Text("Description"),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(20)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.AppColor, width: 2),
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Select Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          GestureDetector(
            onTap: () {
              selectDateFun();
            },
            child: Text(
              selectedDate.toString().substring(0,10),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: ()  {
                  TaskModel task = TaskModel(userId: FirebaseAuth.instance.currentUser!.uid,
                      title: titleController.text,
                      subTitle: subTitleController.text,
                      date: DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch);
                  FirebaseFunctions.addTask(task);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 15),
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 16,
                  shadowColor: AppColors.AppColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: AppColors.AppColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  selectDateFun() async{
   DateTime? chosenDate= await showDatePicker(
      initialDate: selectedDate,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add((Duration(days: 365))));
   if(chosenDate != null){
     selectedDate =  chosenDate ;
     setState(() {

     });
   }
  }
}

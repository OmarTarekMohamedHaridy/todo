import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';

class ShowBottomSheet extends StatefulWidget {
  ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(
                color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter a title ";
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                  label: Text(
                    "Title",
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                  ),
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
              style: TextStyle(
                color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please enter a Description ";
                }
                return null;
              },
              controller: subTitleController,
              decoration: InputDecoration(
                  label: Text(
                    "Description",
                    style: TextStyle(
                      color: provider.Mytheme == ThemeMode.light
                          ? Color(0xff060E1E)
                          : Color(0xffFFFFFF),
                    ),
                  ),
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: provider.Mytheme == ThemeMode.light
                    ? Color(0xff060E1E)
                    : Color(0xffFFFFFF),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectDateFun();
              },
              child: Text(
                selectedDate.toString().substring(0, 10),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: provider.Mytheme == ThemeMode.light
                      ? Color(0xff060E1E)
                      : Color(0xffFFFFFF),
                ),
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      TaskModel task = TaskModel(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          title: titleController.text,
                          subTitle: subTitleController.text,
                          date: DateUtils.dateOnly(selectedDate)
                              .millisecondsSinceEpoch);
                      FirebaseFunctions.addTask(task);
                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    child: Text(
                      "Add Task",
                      style: TextStyle(
                        color: provider.Mytheme == ThemeMode.light
                            ? Color(0xff060E1E)
                            : Color(0xffFFFFFF),
                      ),
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
      ),
    );
  }

  selectDateFun() async {
    DateTime? chosenDate = await showDatePicker(
        initialDate: selectedDate,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add((Duration(days: 365))));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}

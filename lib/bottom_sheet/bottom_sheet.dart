import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/colors.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(mainAxisSize: MainAxisSize.min,
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
          Text(
            "12/7/2020",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20,),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                  child: Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(elevation: 16,shadowColor: AppColors.AppColor,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

                  backgroundColor: AppColors.AppColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

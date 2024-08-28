import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/colors.dart';

class EditTab extends StatelessWidget {
  const EditTab({super.key});
  static const routeName = "edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.AppColor,
        toolbarHeight: 70,
        title: Text(
          "Edit Screen",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 22),
        ),
      ),

    );
  }
}

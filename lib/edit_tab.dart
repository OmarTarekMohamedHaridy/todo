import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/colors.dart';
import 'package:todo/firebase_fun/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/theme.dart';

class EditTab extends StatefulWidget {
  const EditTab({super.key});
  static const routeName = "edit";

  @override
  State<EditTab> createState() => _EditTabState();
}

class _EditTabState extends State<EditTab> {

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(

      appBar: AppBar(
       centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          "Edit Screen",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize:30),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
        
              height:200,
              color:AppColors.AppColor ,),
        
            Padding(
            padding: const EdgeInsets.all(18.0),
        
            child: Card(
              color:provider.Mytheme==ThemeMode.light?
              Colors.white:Color(0xff141922),
              margin: EdgeInsets.only(top: 50),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [Center(child: Text("Edit Task",style: TextStyle(fontSize:25, fontWeight: FontWeight.w400,color:provider.Mytheme==ThemeMode.light?
                  Colors.black:Color(0xffFFFFFF),),)),
                    SizedBox(height: 40,),
                    TextFormField(
                      style: TextStyle(
                        color: provider.Mytheme == ThemeMode.light
                            ? Color(0xff060E1E)
                            : Color(0xffFFFFFF),
                      ),
                      initialValue: taskModel.title,
                      onChanged: (value) {
                        taskModel.title = value ;
                      },
                      decoration: InputDecoration(
                          label: Text("Title",style: TextStyle(    color:provider.Mytheme==ThemeMode.light?
                          Colors.black:Color(0xffFFFFFF),),),
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
                      initialValue: taskModel.subTitle,
                      onChanged: (value) {
                        taskModel.subTitle = value ;
                      },
                      decoration: InputDecoration(
                          label: Text("Description",style: TextStyle(color:provider.Mytheme==ThemeMode.light?
                          Colors.black:Color(0xffFFFFFF),),),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.AppColor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Select Time",
                      style: TextStyle(fontSize:25, fontWeight: FontWeight.w400,color:provider.Mytheme==ThemeMode.light?
                      Colors.black:Color(0xffFFFFFF),),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(

                      onTap: () async{
                     DateTime? newDate = await   selectDateFun() ;
                     if(newDate != null){
                       taskModel.date =newDate.millisecondsSinceEpoch;
                       setState(() {
        
                       });
                     }
                      },
                      child: Text(
                       DateFormat.yMd().format(DateUtils.dateOnly(DateTime.fromMillisecondsSinceEpoch(taskModel.date))),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: provider.Mytheme == ThemeMode.light
                            ? Color(0xff060E1E)
                            : Color(0xffFFFFFF),),
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
                      onPressed: ()async {
                       await  FirebaseFunctions.Update(taskModel);
                       Navigator.pop(context);
                            },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color:provider.Mytheme==ThemeMode.light?
                              Colors.black:Color(0xffFFFFFF),),
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
            ),
          ),]
        ),
      )

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
    return chosenDate;
  }
}

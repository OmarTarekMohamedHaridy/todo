import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/my_provider.dart';

class BottomThemeSheet extends StatelessWidget {
  const BottomThemeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Container(height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            InkWell(
              onTap:  (){provider.changeTheme(ThemeMode.light);
              Navigator.pop(context);},

              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("light",style: TextStyle(color: provider.Mytheme==ThemeMode.light?
                  Colors.white:Colors.black,

                      fontWeight: FontWeight.w600,
                      fontSize:35
                  ),),

                  provider.Mytheme == ThemeMode.dark? SizedBox() :  Icon( Icons.done,size: 30,color: provider.Mytheme==ThemeMode.light?
                  Colors.white:Colors.white,)
                ],
              ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){provider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);},
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("dark",style: TextStyle(

                    fontWeight: FontWeight.w600,
                    fontSize:35,color: provider.Mytheme==ThemeMode.light?
                  Colors.black:Colors.white,
                  ),),
                  provider.Mytheme == ThemeMode.light? SizedBox() : Icon( Icons.done,size: 30,color: provider.Mytheme==ThemeMode.light?
                  Colors.white:Colors.white,)
                  // Icon( Icons.done,size:30)
                ],
              ),)
          ],),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import '../bottom_sheet/bottom_theme_sheet.dart';
import '../providers/my_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          "theme",
          style: TextStyle(
            color: provider.Mytheme == ThemeMode.light
              ? Color(0xff060E1E)
              : Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomThemeSheet();
              },
              isScrollControlled: true,
              backgroundColor: provider.Mytheme == ThemeMode.light
                  ? Color(0xff5D9CEC)
                  : Color(0xff060E1E),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  width: 2,
                  color: provider.Mytheme == ThemeMode.light
                      ? Color(0xff5D9CEC)
                      : Color(0xffFFFFFF),
                )),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                provider.Mytheme == ThemeMode.dark ? "dark" : "light",
                style: TextStyle(
                  color:provider.Mytheme == ThemeMode.light
                      ? Color(0xff060E1E)
                      : Color(0xffFFFFFF) ,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),

      ]),
    );
  }
}

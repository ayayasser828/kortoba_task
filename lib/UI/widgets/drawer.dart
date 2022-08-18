import 'package:flutter/material.dart';
import 'package:kortoba_task/constant/strings.dart';
import 'package:sizer/sizer.dart';
import '../../constant/colors.dart';
import '../../constant/style.dart';

Widget drawer(BuildContext context){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xff398BAF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  'assets/images/p.jpg',
                ),
              ),
              Text('أحمد كرم',style: headerStyle.copyWith(color: Colors.white,fontSize: 14.sp),),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: Color(0xff398BAF),
          ),
          title: const Text('الرئيسية',style: TextStyle(color: Color(0xff398BAF)),),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, home);
          },
        ),
        Container(
          width: 1.w,
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          height: 0.1.h,
          color: lineColor,
        ),
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Color(0xff398BAF),
          ),
          title: const Text('حسابي',style: TextStyle(color: Color(0xff398BAF))),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          width: 1.w,
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          height: 0.08.h,
          color: lineColor,
        ),
        ListTile(
          leading: const Icon(
            Icons.bookmark,
            color: Color(0xff398BAF),
          ),
          title: const Text('المحفوظات',style: TextStyle(color: Color(0xff398BAF))),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, fav);
          },
        ),
      ],
    ),
  );
}